package com.team.mvc.Controller;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.team.mvc.DTO.*;
import com.team.mvc.Interface.IBoardPostService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.util.*;

@Controller
public class BoardController {

    @Autowired
    private IBoardPostService boardPostService;

//----------------------------------------------------------------------------------------------------------------------
    // 커뮤니티 메인 페이지
    @RequestMapping("/boardmain.action")
    public String boardMain(Model model) {
        try {
            // BEST 게시글 로드
            List<BoardPostDTO> bestPosts = null;
            try {
                bestPosts = boardPostService.listBestPosts(5);
            } catch (Exception e) {
                System.err.println("Error loading best posts: " + e.getMessage());
                bestPosts = new ArrayList<>();
            }
            model.addAttribute("bestPosts", bestPosts);

            // 커뮤니티 게시판 로드
            List<BoardDTO> communityBoards = null;
            try {
                communityBoards = boardPostService.getBoardsByCategoryId(4);
            } catch (Exception e) {
                System.err.println("Error loading community boards: " + e.getMessage());
                communityBoards = new ArrayList<>();
            }
            model.addAttribute("communityBoards", communityBoards);

            // 게시판별 인기글 로드
            Map<Integer, List<BoardPostDTO>> boardHotPosts = new HashMap<>();
            if (communityBoards != null) {
                for (BoardDTO board : communityBoards) {
                    try {
                        int boardId = board.getBoardId();
                        int limit = (board.getBoardName().equals("고독한캠핑방")) ? 6 : 5;
                        List<BoardPostDTO> hotPosts = boardPostService.listBoardHotPosts(boardId, limit);
                        boardHotPosts.put(boardId, hotPosts != null ? hotPosts : new ArrayList<>());
                    } catch (Exception e) {
                        System.err.println("Error loading hot posts for board " + board.getBoardName() + ": " + e.getMessage());
                        boardHotPosts.put(board.getBoardId(), new ArrayList<>());
                    }
                }
            }
            model.addAttribute("boardHotPosts", boardHotPosts);

            return "boardMain";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("errorMessage", "서버 오류가 발생했습니다: " + e.getMessage());
            return "error"; // error.jsp 필요
        }
    }
//----------------------------------------------------------------------------------------------------------------------
    // 전체 인기글 페이지
    @RequestMapping("/boardbest.action")
    public String boardBest(@RequestParam(value = "page", defaultValue = "1") int page,
                            @RequestParam(value = "size", defaultValue = "10") int size,
                            Model model) {
        // 공지사항 조회(최대 3개)
        List<BoardPostDTO> notice = boardPostService.listNotice();
        model.addAttribute("notice", notice);

        // 전체 인기글 조회
        List<BoardPostDTO> totalHotPost = boardPostService.listTotalHotPost(null);

        // 페이징 처리
        int totalPostCount = totalHotPost.size();
        Pagenation pagenation = new Pagenation(page, totalPostCount, size, 10);

        model.addAttribute("totalHotPost", totalHotPost);
        model.addAttribute("pagenation", pagenation);

        return "boardBest";
    }

//----------------------------------------------------------------------------------------------------------------------
    // boardTemplate 페이지
    @RequestMapping("/board{boardName}.action")
    public String boardTemplate(@PathVariable(value = "boardName") String boardName,
                                @RequestParam(value = "page", defaultValue = "1") int page,
                                @RequestParam(value = "size", defaultValue = "10") int size,
                                @RequestParam(value = "searchType", required = false) String searchType,
                                @RequestParam(value = "searchKeyword", required = false) String searchKeyword,
                                Model model) {
        // 실제 한글 보드 이름으로 변환
        String actualBoardName = boardName.equals("image") ? "고독한 캠핑방" :
                                 boardName.equals("free") ? "자유 게시판" :
                                 boardName;

        // 게시판 정보 조회
        BoardDTO board = boardPostService.getBoardByName(actualBoardName);

        if (board == null) {
            return "redirect:/boardmain.action";
        }

        int boardId = board.getBoardId();

        List<BoardDTO> communityBoards = null;
        try {
            communityBoards = boardPostService.getBoardsByCategoryId(4);
        } catch (Exception e) {
            System.err.println("Error loading community boards: " + e.getMessage());
            communityBoards = new ArrayList<>();
        }
        model.addAttribute("communityBoards", communityBoards);


        // 공통 로직 처리
        List<BoardPostDTO> notice = boardPostService.listNotice();
        model.addAttribute("notice", notice);

        List<BoardPostDTO> boardHotPosts = boardPostService.listBoardHotPosts(boardId,3);
        model.addAttribute("boardHotPosts", boardHotPosts);

        // 검색 및 페이징 로직
        BoardPostDTO dto = new BoardPostDTO();
        dto.setBoardId(boardId);

        // 검색 처리 로직
        if (searchType != null && searchKeyword != null && !searchKeyword.trim().isEmpty()) {
            dto.setSearchType(searchType);
            dto.setSearchKeyword(searchKeyword);
            model.addAttribute("searchType", searchType);
            model.addAttribute("searchKeyword", searchKeyword);
        }

        int totalPostCount = boardPostService.getTotalPostCount(dto);
        Pagenation pagenation = new Pagenation(page, totalPostCount, size, 10);
        dto.setPagenation(pagenation);

        List<BoardPostDTO> postList = boardPostService.listPostList(dto);

        model.addAttribute("postList", postList);
        model.addAttribute("pagenation", pagenation);
        model.addAttribute("board", board);

        return board.getBoardName().equals("고독한 캠핑방") ? "boardImage" : "boardTemplate";
    }

    // boardTemplate의 AJAX 처리를 위한 메소드
    @RequestMapping("/api/board{boardName}.action")
    @ResponseBody
    public Map<String, Object> boardTemplateApi(@PathVariable(value = "boardName") String boardName,
                                                @RequestParam(value = "page", defaultValue = "1") int page,
                                                @RequestParam(value = "size", defaultValue = "10") int size,
                                                @RequestParam(value = "boardId", required = false) Integer boardId,
                                                @RequestParam(value = "searchType", required = false) String searchType,
                                                @RequestParam(value = "searchKeyword", required = false) String searchKeyword,
                                                @RequestParam(value = "hotOnly", required = false) Boolean hotOnly,
                                                @RequestParam(value = "originalPostNumbers", required = false) String originalPostNumbersJson) {

        Map<String, Object> result = new HashMap<>();

        // 클라이언트에서 전달받은 원본 게시글 번호 맵 파싱
        Map<String, String> originalPostNumbers = new HashMap<>();
        if (originalPostNumbersJson != null && !originalPostNumbersJson.isEmpty()) {
            try {
                // JSON 문자열을 Map으로 변환
                ObjectMapper mapper = new ObjectMapper();
                originalPostNumbers = mapper.readValue(originalPostNumbersJson, new TypeReference<Map<String, String>>() {});
            } catch (Exception e) {
                System.err.println("Error parsing originalPostNumbers: " + e.getMessage());
            }
        }

        // 게시판 정보 조회
        BoardDTO board;
        if (boardId != null && boardId > 0) {
            // boardId가 전달된 경우 해당 ID로 조회
            board = boardPostService.getBoardById(boardId);
        } else {
            // 실제 한글 보드 이름으로 변환
            String actualBoardName = boardName.equals("image") ? "고독한 캠핑방" :
                    boardName.equals("free") ? "자유 게시판" :
                            boardName;
            board = boardPostService.getBoardByName(actualBoardName);
        }

        if (board == null) {
            result.put("error", "게시판을 찾을 수 없습니다.");
            return result;
        }

        // API에 게시판 정보 추가
        result.put("board", board);

        // 공지사항 조회(최대 3개)
        List<BoardPostDTO> notice = boardPostService.listNotice();
        result.put("notice", notice);

        // 인기글 조회 (최대 3개)
        List<BoardPostDTO> boardHotPosts = boardPostService.listBoardHotPosts(board.getBoardId(),3);
        result.put("boardHotPosts", boardHotPosts);

        List<BoardPostDTO> postList;
        Pagenation pagenation;

        // 검색 조건이 담긴 DTO 생성 (공통)
        BoardPostDTO dto = new BoardPostDTO();
        dto.setBoardId(board.getBoardId());

        // 검색 조건 설정 (공통)
        if (searchType != null && searchKeyword != null && !searchKeyword.trim().isEmpty()) {
            dto.setSearchType(searchType);
            dto.setSearchKeyword(searchKeyword);
        }

        if (Boolean.TRUE.equals(hotOnly)) {
            // 인기글만 조회하는 플래그 설정
            dto.setHotOnly(true);

            // 전체 인기글 수 조회
            int totalHotCount = boardPostService.getTotalHotPostCount(dto);

            // 페이징 처리
            pagenation = new Pagenation(page, totalHotCount, size, 10);
            dto.setPagenation(pagenation);

            // 인기글 목록 조회
            postList = boardPostService.listHotPostsWithRownum(dto);

            // 클라이언트에서 전달받은 원본 번호 적용
            for (BoardPostDTO post : postList) {
                String postId = String.valueOf(post.getPostId());
                if (originalPostNumbers.containsKey(postId)) {
                    try {
                        int originalNum = Integer.parseInt(originalPostNumbers.get(postId));
                        post.setRowNum(originalNum);
                    } catch (NumberFormatException e) {
                        // 숫자가 아닌 경우 무시
                    }
                }
            }
        } else {
            // 전체 게시물 수 조회
            int totalPostCount = boardPostService.getTotalPostCount(dto);

            // 페이징 처리
            pagenation = new Pagenation(page, totalPostCount, size, 10);
            dto.setPagenation(pagenation);

            // 일반 게시물 목록 조회
            postList = boardPostService.listPostList(dto);

            // 클라이언트에서 전달받은 원본 번호 적용
            for (BoardPostDTO post : postList) {
                String postId = String.valueOf(post.getPostId());
                if (originalPostNumbers.containsKey(postId)) {
                    try {
                        int originalNum = Integer.parseInt(originalPostNumbers.get(postId));
                        post.setRowNum(originalNum);
                    } catch (NumberFormatException e) {
                        // 숫자가 아닌 경우 무시
                    }
                }
            }
        }

        result.put("postList", postList);
        result.put("pagenation", pagenation);
        result.put("hotOnly", hotOnly);

        return result;
    }

//----------------------------------------------------------------------------------------------------------------------
    // 자유 게시판 페이지
    @RequestMapping("/boardfree.action")
    public String boardFree(@RequestParam(value = "page", defaultValue = "1") int page,
                            @RequestParam(value = "size", defaultValue = "10") int size,
                            @RequestParam(value = "searchType", required = false) String searchType,
                            @RequestParam(value = "searchKeyword", required = false) String searchKeyword,
                            Model model) {

        // 게시판 ID 설정
        int boardId = 7;    // 자유게시판 ID

        // 공지사항 조회(최대 3개)
        List<BoardPostDTO> notice = boardPostService.listNotice();
        model.addAttribute("notice", notice);

        // 인기글 조회 (최대 3개)
        List<BoardPostDTO> boardHotPosts = boardPostService.listBoardHotPosts(7,3);
        model.addAttribute("boardHotPosts", boardHotPosts);


        // 검색 조건이 담길 dto 생성
        BoardPostDTO dto = new BoardPostDTO();
        dto.setBoardId(boardId);

        // 검색 조건 설정
        if (searchType != null && searchKeyword != null && !searchKeyword.trim().isEmpty()) {
            dto.setSearchType(searchType);
            dto.setSearchKeyword(searchKeyword);
            model.addAttribute("searchType", searchType);
            model.addAttribute("searchKeyword", searchKeyword);
        }

        // 전체 게시물 수 조회 (일반 게시물만)
        int totalPostCount = boardPostService.getTotalPostCount(dto);

        // 페이징 처리
        Pagenation pagenation = new Pagenation(page, totalPostCount, size, 10);
        dto.setPagenation(pagenation);

        // 일반 게시물 목록 조회
        List<BoardPostDTO> postList = boardPostService.listPostList(dto);

        // 모델에 데이터 추가
        model.addAttribute("postList", postList);
        model.addAttribute("pagenation", pagenation);

        return "boardFree";
    }

    // 자유 게시판 AJAX 처리를 위한 메소드
    @RequestMapping("/api/boardfree.action")
    @ResponseBody
    public Map<String, Object> boardFreeApi(@RequestParam(value = "page", defaultValue = "1") int page,
                                            @RequestParam(value = "size", defaultValue = "10") int size,
                                            @RequestParam(value = "searchType", required = false) String searchType,
                                            @RequestParam(value = "searchKeyword", required = false) String searchKeyword,
                                            @RequestParam(value = "hotOnly", required = false) Boolean hotOnly,
                                            @RequestParam(value = "originalPostNumbers", required = false) String originalPostNumbersJson) {

        Map<String, Object> result = new HashMap<>();
        int boardId = 7;    // 자유게시판 ID

        // 클라이언트에서 전달받은 원본 게시글 번호 맵 파싱
        Map<String, String> originalPostNumbers = new HashMap<>();
        if (originalPostNumbersJson != null && !originalPostNumbersJson.isEmpty()) {
            try {
                // JSON 문자열을 Map으로 변환
                ObjectMapper mapper = new ObjectMapper();
                originalPostNumbers = mapper.readValue(originalPostNumbersJson, new TypeReference<Map<String, String>>() {});
            } catch (Exception e) {
                // 예외 처리 (로그 출력 등)
                System.err.println("Error parsing originalPostNumbers: " + e.getMessage());
            }
        }

        // 공지사항 조회(최대 3개)
        List<BoardPostDTO> notice = boardPostService.listNotice();
        result.put("notice", notice);

        // 상단에 표시할 최신 인기글 3개 항상 조회
        List<BoardPostDTO> topHotPosts = boardPostService.listBoardHotPosts(boardId, 3);
        result.put("topHotPosts", topHotPosts);

        List<BoardPostDTO> postList;
        Pagenation pagenation;

        // 검색 조건이 담긴 DTO 생성 (공통)
        BoardPostDTO dto = new BoardPostDTO();
        dto.setBoardId(boardId);

        // 검색 조건 설정 (공통)
        if (searchType != null && searchKeyword != null && !searchKeyword.trim().isEmpty()) {
            dto.setSearchType(searchType);
            dto.setSearchKeyword(searchKeyword);
        }

        if (Boolean.TRUE.equals(hotOnly)) {
            // 인기글만 조회하는 플래그 설정
            dto.setHotOnly(true);

            // 전체 인기글 수 조회
            int totalHotCount = boardPostService.getTotalHotPostCount(dto);

            // 페이징 처리
            pagenation = new Pagenation(page, totalHotCount, size, 10);
            dto.setPagenation(pagenation);

            // 인기글 목록 조회
            postList = boardPostService.listHotPostsWithRownum(dto);

            // 클라이언트에서 전달받은 원본 번호 적용
            for (BoardPostDTO post : postList) {
                String postId = String.valueOf(post.getPostId());
                if (originalPostNumbers.containsKey(postId)) {
                    try {
                        int originalNum = Integer.parseInt(originalPostNumbers.get(postId));
                        post.setRowNum(originalNum);
                    } catch (NumberFormatException e) {
                        // 숫자가 아닌 경우 무시
                    }
                }
            }
        } else {
            // 전체 게시물 수 조회
            int totalPostCount = boardPostService.getTotalPostCount(dto);

            // 페이징 처리
            pagenation = new Pagenation(page, totalPostCount, size, 10);
            dto.setPagenation(pagenation);

            // 일반 게시물 목록 조회
            postList = boardPostService.listPostList(dto);

            // 클라이언트에서 전달받은 원본 번호 적용
            for (BoardPostDTO post : postList) {
                String postId = String.valueOf(post.getPostId());
                if (originalPostNumbers.containsKey(postId)) {
                    try {
                        int originalNum = Integer.parseInt(originalPostNumbers.get(postId));
                        post.setRowNum(originalNum);
                    } catch (NumberFormatException e) {
                        // 숫자가 아닌 경우 무시
                    }
                }
            }
        }

        result.put("postList", postList);
        result.put("pagenation", pagenation);
        result.put("hotOnly", hotOnly);

        return result;
    }

    // 자유 게시판 게시글 페이지
    @RequestMapping("/boardfree-post.action")
    public String boardFreePost(@RequestParam(value = "page", defaultValue = "1") int page,
                                @RequestParam(value = "size", defaultValue = "10") int size,
                                @RequestParam(value = "searchType", required = false) String searchType,
                                @RequestParam(value = "searchKeyword", required = false) String searchKeyword,
                                @RequestParam(value="postId", required=false, defaultValue="0") int postId,
                                Model model) {

        // 게시글이 존재하는 경우
        if (postId > 0) {
            // 게시글 정보 조회
            BoardPostDTO dto = new BoardPostDTO();
            dto.setPostId(postId);
            BoardPostDTO post = boardPostService.getPostById(dto);

            if (post != null) {
                // 조회수 증가 처리 (중복 방지 로직 필요 - 세션 등 이용)
                // 현재는 매번 증가하지만, 실제로는 동일 사용자가 짧은 시간 내 재조회 시 증가하지 않도록 해야 함
                boardPostService.increaseViewCount(postId);

                // 첨부파일 조회
                List<AttachmentDTO> attachments = boardPostService.getAttachmentsByPostId(postId);
                post.setAttachments(attachments);

                // 댓글 목록 조회
                List<ReplyDTO> replies = boardPostService.getRepliesByPostId(postId);
                model.addAttribute("replies", replies);

                // 이전글, 다음글 ID 조회
                int prevPostId = boardPostService.getPrevPostId(postId, 7); // 7은 자유게시판 ID
                int nextPostId = boardPostService.getNextPostId(postId, 7);
                model.addAttribute("prevPostId", prevPostId);
                model.addAttribute("nextPostId", nextPostId);

                // 연관 게시글 목록 (최근 게시글 몇 개) 조회
                BoardPostDTO listDto = new BoardPostDTO();
                listDto.setBoardId(7); // 자유게시판 ID
                listDto.setPagenation(new Pagenation(1, 10, 3, 10)); // 첫 페이지, 한 페이지에 3개만 조회
                List<BoardPostDTO> recentPosts = boardPostService.listPostList(listDto);
                model.addAttribute("recentPosts", recentPosts);

                model.addAttribute("post", post);
            } else {
                // 존재하지 않는 게시글인 경우 목록으로 리다이렉트
                return "redirect:/boardfree.action";
            }
        } else {
            // postId가 없거나 0인 경우 목록으로 리다이렉트
            return "redirect:/boardfree.action";
        }

        // 게시판 ID 설정
        int boardId = 7;    // 자유게시판 ID

        BoardPostDTO dto = new BoardPostDTO();
        dto.setBoardId(boardId);

        // 전체 게시물 수 조회 (일반 게시물만)
        int totalPostCount = boardPostService.getTotalPostCount(dto);

        // 페이징 처리
        Pagenation pagenation = new Pagenation(page, totalPostCount, size, 10);
        dto.setPagenation(pagenation);

        // 일반 게시물 목록 조회
        List<BoardPostDTO> postList = boardPostService.listPostList(dto);

        // 모델에 데이터 추가
        model.addAttribute("postList", postList);
        model.addAttribute("pagenation", pagenation);

        return "boardFree-post";
    }


    // 게시판 카테고리별 게시판 목록 조회 (AJAX)
    @GetMapping("/api/boards/category/{categoryId}")
    @ResponseBody
    public List<BoardDTO> getBoardsByCategoryId(@PathVariable("categoryId") int categoryId) {
        List<BoardDTO> boards = boardPostService.getBoardsByCategoryId(categoryId);
        return boards != null ? boards : new ArrayList<>();
    }


    // 게시판별 말머리 목록 조회 (AJAX)
    @GetMapping("/api/post-labels/board/{boardId}")
    @ResponseBody
    public List<BoardPostDTO> getPostLabelsByBoard(@PathVariable("boardId") int boardId) {
//        System.out.println("Received boardId: " + boardId);
        List<BoardPostDTO> labels = boardPostService.getPostLabelsByBoardId(boardId);
        return labels != null ? labels : new ArrayList<>();
    }


    // 자유 게시판 글쓰기 페이지 (게시판 목록, 말머리 목록 조회)
    @RequestMapping(value = "/boardfree-write.action", method = RequestMethod.GET)
    public String boardFreeWrite(Model model) {
        // 커뮤니티 게시판 목록 조회
        List<BoardDTO> communityBoards = boardPostService.getBoardsByCategoryId(4);
        model.addAttribute("communityBoards", communityBoards);

        // 기본 게시판이 자유게시판(ID:7)인 경우 해당 게시판의 말머리 목록 조회
        List<BoardPostDTO> defaultLabels = boardPostService.getPostLabelsByBoardId(7);
        model.addAttribute("postLabels", defaultLabels);

        return "boardFree-write";
    }


    // 자유게시판 글쓰기(글 등록)
    @RequestMapping(value = "/boardfree-write.action", method = RequestMethod.POST)
    public String insertPost(BoardPostDTO dto,
                             @RequestParam(value = "uploadFiles", required = false) List<MultipartFile> uploadFiles,
                             HttpServletRequest request,
                             HttpSession session) {
        // 현재 로그인한 회원의 user_code 가져오기
//            Integer user_code = (Integer) session.getAttribute("user_code");
//            if (user_code == null) {
//                return "redirect:/userlogin.action";
//            }

//        session.setAttribute("userCode", 2);
//        // 세션에서 로그인 정보 확인
//        Integer userCode = (Integer) session.getAttribute("userCode");
        int userCode = 2;
        dto.setUserCode(userCode);

        try {
            System.out.println("게시글 등록 전 DTO 상태: " + dto.getPostId());
            // 게시글 등록
            int postId = boardPostService.insertPost(dto);
            System.out.println("게시글 등록 후 반환된 ID: " + postId);
            System.out.println("게시글 등록 후 DTO 상태: " + dto.getPostId());

            // 첨부파일 처리
            if (uploadFiles != null && !uploadFiles.isEmpty()) {
                // 업로드 경로를 webapp/resources/uploads로 설정
                String uploadPath = request.getServletContext().getRealPath("/resources/uploads/");
                System.out.println("업로드 경로: " + uploadPath);

                // 디렉토리가 없으면 생성
                File directory = new File(uploadPath);
                if (!directory.exists()) {
                    directory.mkdirs();
                    System.out.println("디렉토리 생성 결과: " + directory.mkdirs());
                }

                // 각 파일 처리
                for (int i = 0; i < uploadFiles.size(); i++) {
                    MultipartFile file = uploadFiles.get(i);

                    if (!file.isEmpty()) {
                        // 파일명 중복 방지를 위한 uuid 추가
                        String originalFileName = file.getOriginalFilename();
                        String extension = originalFileName.substring(originalFileName.lastIndexOf("."));
                        String savedFileName = UUID.randomUUID().toString() + extension;

                        // 파일 저장 경로 설정
                        File savedFile = new File(directory, savedFileName);

                        // 파일 저장
                        file.transferTo(savedFile);

                        // DB에 첨부파일 정보 저장
                        AttachmentDTO attachmentDTO = new AttachmentDTO();
                        attachmentDTO.setPostId(postId);
                        System.out.println("첨부파일에 저장되는 게시글 ID: " + postId);
                        attachmentDTO.setAttachmentName(originalFileName);
                        attachmentDTO.setAttachmentPath("/resources/uploads/" + savedFileName); // 상대 경로로 저장
                        attachmentDTO.setAttachmentSize((int)file.getSize());
                        attachmentDTO.setAttachmentOrder(i + 1);

                        boardPostService.insertAttachment(attachmentDTO);
                    }
                }
            }

            // 리다이렉트 URL 결정
            String redirectUrl = "boardfree.action";


            // 게시판 ID에 따른 리다이렉트 URL 결정
            int boardId = dto.getBoardId();
            System.out.println("리다이렉트 URL 결정 - 게시판 ID: " + boardId);

            switch (boardId) {
                case 7: // 자유게시판
                    redirectUrl = "boardfree.action";
                    break;
                case 8: // 장비 정보
                    redirectUrl = "boardgear.action";
                    break;
                case 9: // 캠핑장 정보
                    redirectUrl = "boardmarket.action";
                    break;
                case 10: // 고독한캠핑방
                    redirectUrl = "boardimage.action";
                    break;
                default:
                    redirectUrl = "boardmain.action";
            }
            System.out.println("최종 리다이렉트 URL: " + redirectUrl);

            return "redirect:" + redirectUrl;
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("오류 발생: " + e.getMessage());
            // 에러 발생 시 메인 페이지로 리다이렉트
            return "redirect:boardmain.action";
        }
    }


    // 게시글 수정 페이지
    @RequestMapping("/boardfree-update.action")
    public String boardFreeUpdate(@RequestParam("postId") int postId, HttpSession session, Model model) {
        // 세션에서 로그인한 사용자 코드 가져오기
        Integer userCode = (Integer) session.getAttribute("user_code"); // userCode에서 user_code로 변경
        System.out.println("boardFreeUpdate 메서드 호출됨 - postId: " + postId);

        // 로그인 안 된 경우 로그인 페이지로 리다이렉트 (이미 checkLogin.jsp에서 처리됨)
        if (userCode == null) {
            return "redirect:/login-user.action";
        }

        // 게시글 정보 조회
        BoardPostDTO dto = new BoardPostDTO();
        dto.setPostId(postId);
        BoardPostDTO post = boardPostService.getPostById(dto);


        if (post == null) {
            System.out.println("게시글을 찾을 수 없음");
            return "redirect:/boardfree.action";
        }

        // 현재 로그인한 사용자가 작성자이지 확인
        if (post.getUserCode() != userCode) {
            System.out.println("권한 없음");
            return "redirect:/boardfree.action";
        }

        // 말머리 목록 조회
        List<BoardPostDTO> postLabels = boardPostService.getPostLabelsByBoardId(7); // 자유게시판 ID

        // 커뮤니티 게시판 목록 조회
        List<BoardDTO> communityBoards = boardPostService.getBoardsByCategoryId(4);

        System.out.println("모델 속성 추가 - post, postLabels, isUpdate(true)");
        model.addAttribute("post", post);
        model.addAttribute("postLabels", postLabels);
        model.addAttribute("communityBoards", communityBoards);
        model.addAttribute("isUpdate", true);

        System.out.println("boardfree-write 뷰로 리턴");
        return "boardFree-write";
    }


    // 게시글 수정 처리를 위한 api
    @RequestMapping(value = "/api/post/update.action", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> updatePost(@RequestPart("post") BoardPostDTO dto,
                                          @RequestPart(value = "attachments", required = false) List<MultipartFile> attachments,
                                          HttpSession session) {
        Map<String, Object> result = new HashMap<>();

        try {
            // 세션에서 로그인한 사용자 코드 가져오기
            Integer userCode = (Integer) session.getAttribute("user_code"); // userCode에서 user_code로 변경
            System.out.println("업데이트 API - 사용자 코드: " + userCode + ", 게시글 ID: " + dto.getPostId());
            dto.setUserCode(userCode);

            // 로그인 안 된 경우 (이미 checkLogin.jsp에서 처리됨)
            if (userCode == null) {
                result.put("success", false);
                result.put("message", "로그인이 필요합니다.");
                return result;
            }

            // 게시글 정보 조회
            BoardPostDTO post = boardPostService.getPostById(dto);
            System.out.println("게시글 작성자 코드: " + (post != null ? post.getUserCode() : "게시글 없음"));

            // 게시글이 존재하는지, 작성자가 현재 로그인한 사용자가 맞는지 확인
            if (post != null) {
                int affectedRows = boardPostService.updatePost(dto);
                System.out.println("업데이트 결과 - 영향 받은 행: " + affectedRows);

                if (affectedRows > 0) {
                    result.put("success", true);
                    result.put("message", "게시글이 수정되었습니다.");
                    result.put("postId", dto.getPostId());
                } else {
                    result.put("success", false);
                    result.put("message", "게시글 수정에 실패했습니다.");
                }
            }
            else {
                result.put("success", false);
                result.put("message", "게시글이 존재하지 않거나 수정 권한이 없습니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
            result.put("message", "서버 오류가 발생했습니다: " + e.getMessage());
        }

        return result;
    }

    // 게시글 삭제 API
    @RequestMapping(value = "/api/post/delete.action", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> deletePost(@RequestBody BoardPostDTO dto,
                                          HttpSession session) {
        Map<String, Object> result = new HashMap<>();

        try {
            // 세션에서 로그인한 사용자 코드 가져오기
            Integer userCode = (Integer) session.getAttribute("user_code"); // userCode에서 user_code로 변경

            // 로그인 안 된 경우 (이미 checkLogin.jsp에서 처리됨)
            if (userCode == null) {
                result.put("success", false);
                result.put("message", "로그인이 필요합니다.");
                return result;
            }

            // 게시글 정보 조회
            BoardPostDTO post = boardPostService.getPostById(dto);

            // 게시글이 존재하는지, 작성자가 현재 로그인한 사용자인지 확인
            if (post != null && post.getUserCode() == userCode) {
                // 트랜잭션으로 게시글과 댓글 함께 삭제
                boolean deleteSuccess = boardPostService.deletePostWithReplies(dto.getPostId());

                if (deleteSuccess) {
                    result.put("success", true);
                    result.put("message", "게시글이 삭제되었습니다.");
                } else {
                    result.put("success", false);
                    result.put("message", "게시글 삭제에 실패했습니다.");
                }
            } else {
                result.put("success", false);
                result.put("message", "게시글이 존재하지 않거나 삭제 권한이 없습니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
            result.put("message", "서버 오류가 발생했습니다: " + e.getMessage());
        }

        return result;
    }

//----------------------------------------------------------------------------------------------------------------------
    // 고독한 캠핑방 페이지
    @RequestMapping("/boardimage.action")
    public String boardImage(@RequestParam(value = "page", defaultValue = "1") int page,
                             @RequestParam(value = "size", defaultValue = "9") int size,
                             @RequestParam(value = "searchType", required = false) String searchType,
                             @RequestParam(value = "searchKeyword", required = false) String searchKeyword,
                             Model model) {

        // 게시판 ID 설정
        int boardId = 8;    // 자유게시판 ID

        // 공지사항 조회(최대 3개)
        List<BoardPostDTO> notice = boardPostService.listNotice();
        model.addAttribute("notice", notice);

        // 검색 조건이 담길 dto 생성
        BoardPostDTO dto = new BoardPostDTO();
        dto.setBoardId(boardId);

        // 검색 조건 설정
        if (searchType != null && searchKeyword != null && !searchKeyword.trim().isEmpty()) {
            dto.setSearchType(searchType);
            dto.setSearchKeyword(searchKeyword);
            model.addAttribute("searchType", searchType);
            model.addAttribute("searchKeyword", searchKeyword);
        }

        // 전체 게시물 수 조회 (일반 게시물만)
        int totalPostCount = boardPostService.getTotalPostCount(dto);

        // 페이징 처리
        Pagenation pagenation = new Pagenation(page, totalPostCount, size, 10);
        dto.setPagenation(pagenation);

        // 일반 게시물 목록 조회
        List<BoardPostDTO> postList = boardPostService.listPostList(dto);

        // 모델에 데이터 추가
        model.addAttribute("postList", postList);
        model.addAttribute("pagenation", pagenation);

        return "boardImage";
    }


    // 고독한 캠핑방 게시글 페이지
    @RequestMapping("boardimage-post.action")
    public String boardImagePost(@RequestParam(value="postId", required=false, defaultValue="0") int postId, Model model) {
        if (postId > 0) {
            BoardPostDTO dto = new BoardPostDTO();
            dto.setPostId(postId);
            BoardPostDTO post = boardPostService.getPostById(dto);
            if (post != null) {
                model.addAttribute("post", post);
            }
        }
        return "boardImage-post";
    }


    // 고독한캠핑방 AJAX 처리를 위한 메소드
    @RequestMapping("/api/boardimage.action")
    @ResponseBody
    public Map<String, Object> boardImageApi(@RequestParam(value = "page", defaultValue = "1") int page,
                                             @RequestParam(value = "size", defaultValue = "10") int size,
                                             @RequestParam(value = "searchType", required = false) String searchType,
                                             @RequestParam(value = "searchKeyword", required = false) String searchKeyword,
                                             @RequestParam(value = "hotOnly", required = false) Boolean hotOnly,
                                             @RequestParam(value = "originalPostNumbers", required = false) String originalPostNumbersJson) {

        Map<String, Object> result = new HashMap<>();
        int boardId = 8;    // 고독한캠핑방 ID

        // 클라이언트에서 전달받은 원본 게시글 번호 맵 파싱
        Map<String, String> originalPostNumbers = new HashMap<>();
        if (originalPostNumbersJson != null && !originalPostNumbersJson.isEmpty()) {
            try {
                // JSON 문자열을 Map으로 변환
                ObjectMapper mapper = new ObjectMapper();
                originalPostNumbers = mapper.readValue(originalPostNumbersJson, new TypeReference<Map<String, String>>() {});
            } catch (Exception e) {
                System.err.println("Error parsing originalPostNumbers: " + e.getMessage());
            }
        }

        // 공지사항 조회(최대 3개)
        List<BoardPostDTO> notice = boardPostService.listNotice();
        result.put("notice", notice);

        List<BoardPostDTO> postList;
        Pagenation pagenation;

        // 검색 조건이 담긴 DTO 생성 (공통)
        BoardPostDTO dto = new BoardPostDTO();
        dto.setBoardId(boardId);

        // 검색 조건 설정 (공통)
        if (searchType != null && searchKeyword != null && !searchKeyword.trim().isEmpty()) {
            dto.setSearchType(searchType);
            dto.setSearchKeyword(searchKeyword);
        }

        if (Boolean.TRUE.equals(hotOnly)) {
            // 인기글만 조회하는 플래그 설정
            dto.setHotOnly(true);

            // 전체 인기글 수 조회
            int totalHotCount = boardPostService.getTotalHotPostCount(dto);

            // 페이징 처리
            pagenation = new Pagenation(page, totalHotCount, size, 10);
            dto.setPagenation(pagenation);

            // 인기글 목록 조회
            postList = boardPostService.listHotPostsWithRownum(dto);

            // 클라이언트에서 전달받은 원본 번호 적용
            for (BoardPostDTO post : postList) {
                String postId = String.valueOf(post.getPostId());
                if (originalPostNumbers.containsKey(postId)) {
                    try {
                        int originalNum = Integer.parseInt(originalPostNumbers.get(postId));
                        post.setRowNum(originalNum);
                    } catch (NumberFormatException e) {
                        // 숫자가 아닌 경우 무시
                    }
                }
            }
        } else {
            // 전체 게시물 수 조회
            int totalPostCount = boardPostService.getTotalPostCount(dto);

            // 페이징 처리
            pagenation = new Pagenation(page, totalPostCount, size, 10);
            dto.setPagenation(pagenation);

            // 일반 게시물 목록 조회
            postList = boardPostService.listPostList(dto);

            // 클라이언트에서 전달받은 원본 번호 적용
            for (BoardPostDTO post : postList) {
                String postId = String.valueOf(post.getPostId());
                if (originalPostNumbers.containsKey(postId)) {
                    try {
                        int originalNum = Integer.parseInt(originalPostNumbers.get(postId));
                        post.setRowNum(originalNum);
                    } catch (NumberFormatException e) {
                        // 숫자가 아닌 경우 무시
                    }
                }
            }
        }

        result.put("postList", postList);
        result.put("pagenation", pagenation);
        result.put("hotOnly", hotOnly);

        return result;
    }

    // 고독한 캠핌방 글쓰기
    @RequestMapping("/boardimage-write.action")
    public String boardImageWrite(){
        return "boardImage-write";
    }

//----------------------------------------------------------------------------------------------------------------------
    // 공지사항 페이지
    @RequestMapping("/notice.action")
    public String notice(@RequestParam(value = "page", defaultValue = "1") int page,
                         @RequestParam(value = "size", defaultValue = "10") int size,
                         @RequestParam(value = "searchType", required = false) String searchType,
                         @RequestParam(value = "searchKeyword", required = false) String searchKeyword,
                         HttpSession session,
                         Model model) {
        // 게시판 ID 설정
        int boardId = 1; // 공지사항

        // 전체 공지사항 조회
        List<BoardPostDTO> noticeList = boardPostService.listTotalNotice();
        model.addAttribute("noticeList", noticeList);

        // 검색 조건이 담길 dto 생성
        BoardPostDTO dto = new BoardPostDTO();
        dto.setBoardId(boardId);

        // 검색 조건 설정
        if (searchType != null && searchKeyword != null && !searchKeyword.trim().isEmpty()) {
            dto.setSearchType(searchType);
            dto.setSearchKeyword(searchKeyword);
            model.addAttribute("searchType", searchType);
            model.addAttribute("searchKeyword", searchKeyword);
        }

        // 공지사항 총 개수 조회
        int getTotalNoticeCount = boardPostService.getTotalNoticeCount(dto);

        // 페이징 처리
        Pagenation pagenation = new Pagenation(page, getTotalNoticeCount, size, 10);
        dto.setPagenation(pagenation);

        model.addAttribute("pagenation", pagenation);
        return "notice";
    }


    // 공지사항 게시글 페이지
    @RequestMapping("/noticepost.action")
    public String noticepost(@RequestParam(value = "page", defaultValue = "1") int page,
                             @RequestParam(value = "size", defaultValue = "10") int size,
                             @RequestParam(value = "searchType", required = false) String searchType,
                             @RequestParam(value = "searchKeyword", required = false) String searchKeyword,
                             @RequestParam(value = "postId", required = false, defaultValue = "0") int postId,
                             Model model) {
        // 게시글이 존재하는 경우
        if (postId > 0) {
            // 게시글 정보 조회
            BoardPostDTO dto = new BoardPostDTO();
            dto.setPostId(postId);
            BoardPostDTO post = boardPostService.getPostById(dto);

            if (post != null) {
                // 조회수 증가 처리 (중복 방지 로직 필요 - 세션 등 이용)
                // 현재는 매번 증가하지만, 실제로는 동일 사용자가 짧은 시간 내 재조회시 증가하지 않도록 해야함
                boardPostService.increaseViewCount(postId);

                // 첨부파일 조회
                List<AttachmentDTO> attachments = boardPostService.getAttachmentsByPostId(postId);
                System.out.println("공지사항 ID: " + postId + ", 첨부파일 조회: " + (attachments != null ? attachments.size() : "null"));

                post.setAttachments(attachments);

                // 이전글, 다음글 ID 조회
                int prevPostId = boardPostService.getPrevPostId(postId, 1);
                int nextPostId = boardPostService.getNextPostId(postId, 1);
                model.addAttribute("prevPostId", prevPostId);
                model.addAttribute("nextPostId", nextPostId);

                // 게시글 목록 (최근 게시글) 조회
                BoardPostDTO listDto = new BoardPostDTO();
                listDto.setBoardId(1); // 공지사항
                listDto.setPagenation(new Pagenation(1, 10, 3, 10)); // 첫 페이지, 한 페이지에 3개만 조회
                List<BoardPostDTO> recentPosts = boardPostService.listPostList(listDto);
                model.addAttribute("recentPosts", recentPosts);

                model.addAttribute("post", post);
            } else {
                // 존재하지 않는 게시글인 경우 목록으로 리다이렉트
                return "redirect:/notice.action";
            }
        } else {
                // postId가 없거나 0인 경우 목록으로 리다이렉트
                return "redirect:/notice.action";
        }

        // 게시판 ID 설정
        int boardId = 1;    // 공지사항

        BoardPostDTO dto = new BoardPostDTO();
        dto.setBoardId(boardId);

        // 전체 공지사항 수 조회
        int totalNoticeCount = boardPostService.getTotalNoticeCount(dto);

        // 페이징 처리
        Pagenation pagenation = new Pagenation(page, totalNoticeCount, size, 10);
        dto.setPagenation(pagenation);

        // 공지사항 조회
        List<BoardPostDTO> noticeList = boardPostService.listTotalNotice();

        // 모델 데이터 추가
        model.addAttribute("noticeList", noticeList);
        model.addAttribute("pagenation", pagenation);

        return "noticePost";
    }



    // 공지사항 작성 페이지
    @RequestMapping(value = "/notice-write.action", method = RequestMethod.GET)
    public String noticeWrite(Model model, HttpSession session) {
        // 관리자 권한 확인 (관리자만 공지사항 작성 가능)
//        Integer userCode = (Integer) session.getAttribute("user_code");
//        Integer userGrade = (Integer) session.getAttribute("user_grade");

        // 테스트를 위해 세션에 관리자 정보 직접 설정
        session.setAttribute("user_code", 1);  // ADMIN1 계정의 user_code
        session.setAttribute("user_grade", 1); // 관리자 등급

        // 관리자가 아니면 공지사항 목록으로 리다이렉트
        // userGrade 값이 1인 경우 관리자로 가정 (실제 구현에 맞게 수정 필요)
//        if (userGrade == null || userGrade > 1) {
//            return "redirect:/notice.action";
//        }

        // 공지사항 게시판의 말머리 목록 조회 (boardId = 1)
        List<BoardPostDTO> postLabels = boardPostService.getPostLabelsByBoardId(1);
        model.addAttribute("postLabels", postLabels);

        return "notice-write";
    }


    // 공지사항 등록 처리
    @RequestMapping(value = "/notice-write.action", method = RequestMethod.POST)
    public String insertNotice(BoardPostDTO dto,
                               @RequestParam(value = "uploadFiles", required = false) List<MultipartFile> uploadFiles,
                               HttpServletRequest request,
                               HttpSession session) {
        // 관리자 권한 확인
//        Integer userCode = (Integer) session.getAttribute("user_code");
//        Integer userGrade = (Integer) session.getAttribute("user_grade");

        // 관리자가 아니면 공지사항 목록으로 리다이렉트
//        if (userGrade == null || userGrade > 1) {
//            return "redirect:/notice.action";
//        }

        // 게시판 ID를 공지사항(1)으로 강제 설정
//        dto.setBoardId(1);
//        dto.setUserCode(userCode);

        // 테스트를 위해 세션에 관리자 정보 직접 설정 (없는 경우에만)
        if (session.getAttribute("user_code") == null) {
            session.setAttribute("user_code", 1);
            session.setAttribute("user_grade", 1);
        }

        // 게시판 ID를 공지사항(1)으로 강제 설정
        dto.setBoardId(1);
        dto.setUserCode(1); // 강제로 ADMIN1 계정의 user_code 설정

        try {
            // 공지사항 등록
            int postId = boardPostService.insertPost(dto);

            // 첨부파일 처리
            if (uploadFiles != null && !uploadFiles.isEmpty()) {
                // 업로드 경로를 webapp/resources/uploads로 설정
                String uploadPath = request.getServletContext().getRealPath("/resources/uploads/");
                System.out.println("업로드 경로: " + uploadPath);

                // 디렉토리가 없으면 생성
                File directory = new File(uploadPath);
                if (!directory.exists()) {
                    directory.mkdirs();
                    System.out.println("디렉토리 생성 결과: " + directory.mkdirs());
                }

                // 각 파일 처리
                for (int i = 0; i < uploadFiles.size(); i++) {
                    MultipartFile file = uploadFiles.get(i);

                    if (!file.isEmpty()) {
                        // 파일명 중복 방지를 위한 uuid 추가
                        String originalFileName = file.getOriginalFilename();
                        String extension = originalFileName.substring(originalFileName.lastIndexOf("."));
                        String savedFileName = UUID.randomUUID().toString() + extension;

                        // 파일 저장 경로 설정
                        File savedFile = new File(directory, savedFileName);

                        // 파일 저장
                        file.transferTo(savedFile);

                        // DB에 첨부파일 정보 저장
                        AttachmentDTO attachmentDTO = new AttachmentDTO();
                        attachmentDTO.setPostId(postId);
                        System.out.println("첨부파일에 저장되는 게시글 ID: " + postId);
                        attachmentDTO.setAttachmentName(originalFileName);
                        attachmentDTO.setAttachmentPath("/resources/uploads/" + savedFileName); // 상대 경로로 저장
                        attachmentDTO.setAttachmentSize((int)file.getSize());
                        attachmentDTO.setAttachmentOrder(i + 1);

                        boardPostService.insertAttachment(attachmentDTO);
                    }
                }
            }

            // 등록 성공 시 공지사항 목록으로 리다이렉트
            return "redirect:/notice.action";
        } catch (Exception e) {
            e.printStackTrace();
            // 에러 발생 시 공지사항 목록으로 리다이렉트
            return "redirect:/notice.action";
        }
    }


    // 공지사항 수정 페이지
    @RequestMapping("/notice-update.action")
    public String noticeUpdate(@RequestParam("postId") int postId, HttpSession session, Model model) {
        // 관리자 권한 확인
        Integer userCode = (Integer) session.getAttribute("user_code");
        Integer userGrade = (Integer) session.getAttribute("user_grade");

        // 관리자가 아니면 공지사항 목록으로 리다이렉트
        if (userGrade == null || userGrade > 1) {
            return "redirect:/notice.action";
        }

        // 게시글 정보 조회
        BoardPostDTO dto = new BoardPostDTO();
        dto.setPostId(postId);
        BoardPostDTO post = boardPostService.getPostById(dto);

        if (post == null) {
            return "redirect:/notice.action";
        }

        // 공지사항 게시판의 말머리 목록 조회
        List<BoardPostDTO> postLabels = boardPostService.getPostLabelsByBoardId(1);

        model.addAttribute("post", post);
        model.addAttribute("postLabels", postLabels);
        model.addAttribute("isUpdate", true);

        return "notice-write";
    }


    // 공지사항 수정 처리를 위한 API
    @RequestMapping(value = "/api/notice/update.action", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> updateNotice(@RequestBody BoardPostDTO dto, HttpSession session) {
        Map<String, Object> result = new HashMap<>();

        try {
            // 관리자 권한 확인
            Integer userCode = (Integer) session.getAttribute("user_code");
            Integer userGrade = (Integer) session.getAttribute("user_grade");

            // 관리자가 아니면 권한 없음 응답
            if (userGrade == null || userGrade > 1) {
                result.put("success", false);
                result.put("message", "공지사항 관리 권한이 없습니다.");
                return result;
            }

            // 게시판 ID를 공지사항(1)으로 강제 설정
            dto.setBoardId(1);
            dto.setUserCode(userCode);

            // 게시글 존재 여부 확인
            BoardPostDTO post = boardPostService.getPostById(dto);

            if (post != null) {
                int affectedRows = boardPostService.updatePost(dto);

                if (affectedRows > 0) {
                    result.put("success", true);
                    result.put("message", "공지사항이 수정되었습니다.");
                    result.put("postId", dto.getPostId());
                } else {
                    result.put("success", false);
                    result.put("message", "공지사항 수정에 실패했습니다.");
                }
            } else {
                result.put("success", false);
                result.put("message", "존재하지 않는 공지사항입니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
            result.put("message", "서버 오류가 발생했습니다: " + e.getMessage());
        }

        return result;
    }


    // 공지사항 삭제 처리를 위한 API
    @RequestMapping(value = "/api/notice/delete.action", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> deleteNotice(@RequestBody BoardPostDTO dto, HttpSession session) {
        Map<String, Object> result = new HashMap<>();

        try {
            // 세션에서 관리자 정보 가져오기
            Integer userGrade = (Integer) session.getAttribute("user_grade");
            Integer userCode = (Integer) session.getAttribute("user_code");

            System.out.println("삭제 요청 - 관리자 등급: " + userGrade + ", 관리자 코드: " + userCode);

            // 관리자가 아니면 권한 없음 응답
            if (userGrade == null || userGrade > 1) {
                result.put("success", false);
                result.put("message", "공지사항 관리 권한이 없습니다.");
                return result;
            }

            // 삭제자 정보 기록 (추적용)
            dto.setUserCode(userCode);

            // 콘솔에 로그 출력 (실제로는 로그 테이블에 저장)
            System.out.println("관리자(" + userCode + ")가 공지사항 ID: " + dto.getPostId() + " 삭제 시도");

            // 게시글 정보 조회
            BoardPostDTO post = boardPostService.getPostById(dto);

            if (post != null) {
                int affectedRows = boardPostService.deletePost(dto);

                if (affectedRows > 0) {
                    System.out.println("삭제 성공 - 관리자: " + userCode + ", 게시글: " + dto.getPostId());
                    result.put("success", true);
                    result.put("message", "공지사항이 삭제되었습니다.");
                } else {
                    System.out.println("삭제 실패 - DB 오류");
                    result.put("success", false);
                    result.put("message", "공지사항 삭제에 실패했습니다.");
                }
            } else {
                System.out.println("존재하지 않는 게시글: " + dto.getPostId());
                result.put("success", false);
                result.put("message", "존재하지 않는 공지사항입니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
            result.put("message", "서버 오류가 발생했습니다: " + e.getMessage());
        }

        return result;
    }

//----------------------------------------------------------------------------------------------------------------------
    // 이벤트 페이지
    @RequestMapping("/event.action")
    public String event(){
        return "event";
    }
//----------------------------------------------------------------------------------------------------------------------

    // 추천 수 증가
    @RequestMapping(value = "/api/post/recommend.action", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> recommendPost(@RequestBody BoardPostDTO dto, HttpSession session) {
        Map<String, Object> result = new HashMap<>();

        try {
            // 로그인 사용자 확인
            Integer userCode = (Integer) session.getAttribute("user_code");

            // 테스트용 임시 코드
            if (userCode == null) {
                userCode = 2;
                session.setAttribute("user_code", userCode);
            }

            // 사용자 코드 설정
            dto.setUserCode(userCode);

            // 이미 추천했는지 확인
            boolean alreadyRecommended = boardPostService.checkRecommend(dto);

            if (alreadyRecommended) {
                // 이미 추천한 경우
                result.put("success", false);
                result.put("message", "이미 추천한 게시글입니다.");

                // 게시글 정보 다시 조회하여 현재 추천 수 포함
                BoardPostDTO currentPost = boardPostService.getPostById(dto);
                result.put("recommendCount", currentPost.getRecommendCount());
            } else {
                // 아직 추천하지 않은 경우 - 추천 추가
                int insertResult = boardPostService.insertRecommend(dto);

                if (insertResult > 0) {
                    // HOT_POST_LOG에 기록 (서비스 내부에서 추천수 체크)
                    boardPostService.insertHotPostLog(dto);

                    // 게시글 정보 다시 조회
                    BoardPostDTO updatedPost = boardPostService.getPostById(dto);
                    int recommendCount = updatedPost.getRecommendCount();

                    result.put("success", true);
                    result.put("message", "게시글을 추천했습니다.");
                    result.put("recommendCount", updatedPost.getRecommendCount());
                } else {
                    result.put("success", false);
                    result.put("message", "추천 처리에 실패했습니다.");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
            result.put("message", "서버 오류가 발생했습니다: " + e.getMessage());
        }

        return result;
    }

    // 추천 상태 확인 API
    @RequestMapping(value = "/api/post/checkRecommend.action", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> checkRecommendStatus(@RequestBody BoardPostDTO dto, HttpSession session) {
        Map<String, Object> result = new HashMap<>();

        try {
            // 로그인 사용자 확인
            Integer userCode = (Integer) session.getAttribute("user_code");

            // 테스트용 임시 코드
            if (userCode == null) {
                userCode = 2;
                session.setAttribute("user_code", userCode);
            }

            // 사용자 코드 설정
            dto.setUserCode(userCode);

            // 추천 상태 확인
            boolean isRecommended = boardPostService.checkRecommend(dto);

            result.put("success", true);
            result.put("isRecommended", isRecommended);
        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
            result.put("isRecommended", false);
            result.put("message", "추천 상태 확인 중 오류가 발생했습니다: " + e.getMessage());
        }

        return result;
    }

    // 북마크 API
    @RequestMapping(value = "/api/post/bookmark.action", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> bookmarkPost(@RequestBody BoardPostDTO dto, HttpSession session) {
        Map<String, Object> result = new HashMap<>();

        try{
            // 로그인 사용자 확인
            Integer userCode = (Integer) session.getAttribute("user_code");

            if (userCode == null) {
                userCode = 2;
                session.setAttribute("user_code", userCode);
            }

            // 사용자 코드 설정
            dto.setUserCode(userCode);

            // 이미 북마크했는지 확인
            boolean isBookmarked = boardPostService.checkBookmark(dto);

            if (isBookmarked) {
                // 이미 북마큰한 경우 - 북마크 삭제
                int deleteResult = boardPostService.deleteBookmark(dto);

                if (deleteResult > 0) {
                    result.put("success", true);
                    result.put("isBookmarked", isBookmarked);
                    result.put("message", "북마크가 삭제되었습니다.");
                } else {
                    result.put("success", false);
                    result.put("message", "북마크 추가에 실패했습니다.");
                }
            } else {
                // 아직 북마크하지 않은 경우 - 북마크 추가
                int insertResult = boardPostService.insertBookmark(dto);

                if (insertResult > 0) {
                    result.put("success", true);
                    result.put("isBookmarked", true);
                    result.put("message", "북마크에 추가되었습니다.");
                } else {
                    result.put("success", false);
                    result.put("message", "북마크 추가에 실패했습니다.");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
            result.put("message", "서버 오류가 발생했습니다." + e.getMessage());
        }
        return result;
    }


    // 북마크 상태 확인 API
    @RequestMapping(value = "/api/post/checkbookmark.action", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> checkBookmark(@RequestBody BoardPostDTO dto, HttpSession session) {
        Map<String, Object> result = new HashMap<>();

        try {
            // 로그인 사용자 확인
            Integer userCode = (Integer) session.getAttribute("user_code");

            // 테스트용 임시 코드 (실제 구현시 제거)
            if (userCode == null) {
                userCode = 2;
                session.setAttribute("user_code", userCode);
            }

            // 사용자 코드 설정
            dto.setUserCode(userCode);

            // 북마크 상태 확인
            boolean isBookmarked = boardPostService.checkBookmark(dto);

            result.put("success", true);
            result.put("isBookmarked", isBookmarked);
        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
            result.put("isBookmarked", false);
            result.put("message", "북마크 상태 확인 중 오류가 발생했습니다: " + e.getMessage());
        }

        return result;
    }
}
