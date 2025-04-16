package com.team.mvc.Controller;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.team.mvc.DTO.*;
import com.team.mvc.Interface.IBoardPostService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.util.Objects;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class BoardController {

    @Autowired
    private IBoardPostService boardPostService;

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
    public String insertPost(@ModelAttribute("userCode") Integer userCode,
                             BoardPostDTO dto) {

        dto.setUserCode(userCode);

        try {
            // 게시글 등록
            int postId = boardPostService.insertPost(dto);

            // 게시판 ID에 따른 리다이렉트 URL 결정
            int boardId = dto.getBoardId();
            String redirectUrl;

            switch (boardId) {
                case 7: // 자유게시판
                    redirectUrl = "boardfree.action";
                    break;
                case 8: // 장비 정보
                    redirectUrl = "boardgear.action";
                    break;
                case 9: // 캠핑장 정보
                    redirectUrl = "boardmarket.action=";
                    break;
                case 10: // 고독한캠핑방
                    redirectUrl = "boardimage.action";
                    break;
                default:
                    redirectUrl = "boardmain.action";
            }

            return "redirect:" + redirectUrl;
        } catch (Exception e) {
            e.printStackTrace();
            // 에러 발생 시 메인 페이지로 리다이렉트
            return "redirect:boardmain.action";
        }
    }


    // 게시글 수정 페이지
    @RequestMapping("/boardfree-update.action")
    public String boardFreeUpdate(@RequestParam("postId") int postId,
                                  @ModelAttribute("userCode") Integer userCode,
                                  Model model) {
        // 게시글 정보 조회
        BoardPostDTO dto = new BoardPostDTO();
        dto.setPostId(postId);
        BoardPostDTO post = boardPostService.getPostById(dto);

        if (post == null || !Objects.equals(post.getUserCode(), userCode)) {
            return "redirect:/boardfree.action";
        }

        // 말머리 목록 조회
        List<BoardPostDTO> postLabels = boardPostService.getPostLabelsByBoardId(7); // 자유게시판 ID


        model.addAttribute("post", post);
        model.addAttribute("postLabels", postLabels);
        model.addAttribute("isUpdate", true);

        return "boardfree-write";
    }


    // 게시글 수정 처리를 위한 api
    @RequestMapping(value = "/api/post/update.action", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> updatePost(@ModelAttribute("userCode") Integer userCode,
                                          @RequestBody BoardPostDTO dto) {
        Map<String, Object> result = new HashMap<>();

        try {
            // 게시글 정보 조회
            BoardPostDTO post = boardPostService.getPostById(dto);

            // 게시글이 존재하는지, 작성자가 현재 로그인한 사용자가 맞는지 확인
            if (post != null && post.getUserCode() != userCode) {
                int affectedRows = boardPostService.updatePost(dto);

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
    public Map<String, Object> deletePost(@ModelAttribute("userCode") Integer userCode,
                                          @RequestBody BoardPostDTO dto) {
        Map<String, Object> result = new HashMap<>();

        try {
            // 게시글 정보 조회
            BoardPostDTO post = boardPostService.getPostById(dto);

            // 게시글이 존재하는지, 작성자가 현재 로그인한 사용자인지 확인
            if (post != null && post.getUserCode() == userCode) {
                int affectedRows = boardPostService.deletePost(dto);

                if (affectedRows > 0) {
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


    // 고독한 캠핑방 페이지
    @RequestMapping("/boardimage.action")
    public String boardImage(){
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

    // 이벤트 페이지
    @RequestMapping("/event.action")
    public String event(){
        return "event";
    }

    // 공지사항 페이지
    @RequestMapping("/notice.action")
    public String notice(){
        return "notice";
    }
}
