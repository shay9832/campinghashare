package com.team.mvc.Controller;

import com.team.mvc.DTO.BoardPostDTO;
import com.team.mvc.DTO.Pagenation;
import com.team.mvc.Interface.IBoardPostService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class BoardController {

    @Autowired
    private IBoardPostService boardPostService;


    @RequestMapping("/boardmain.action")
    public String boardMain(){
        return "boardMain";
    }

    @RequestMapping("/boardbest.action")
    public String boardBest(@RequestParam(value = "page", defaultValue = "1") int page,
                            @RequestParam(value = "size", defaultValue = "10") int size,
                            Model model) {
        // 전체 인기글 조회
        List<BoardPostDTO> totalHotPost = boardPostService.listTotalHotPost(null);

        // 페이징 처리
        int totalPostCount = totalHotPost.size();
        Pagenation pagenation = new Pagenation(page, totalPostCount, size, 10);

        model.addAttribute("totalHotPost", totalHotPost);
        model.addAttribute("pagenation", pagenation);

        return "boardBest";
    }

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
        List<BoardPostDTO> hotPost = boardPostService.listHotPost(boardId);
        model.addAttribute("hotPost", hotPost);


        // 일반 게시물 조회
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

    @RequestMapping("/boardfree-post.action")
    public String boardFreePost(@RequestParam(value="postId", required=false, defaultValue="0") int postId){
        return "boardFree-post";
    }

    @RequestMapping("/boardfree-write.action")
    public String boardFreeWrite(){
        return "boardFree-write";
    }

    @RequestMapping("/boardimage.action")
    public String boardImage(){
        return "boardImage";
    }

    @RequestMapping("boardimage-post.action")
    public String boardImagePost(@RequestParam(value="postId", required=false, defaultValue="0") int postId){
        return "boardImage-post";
    }

    @RequestMapping("/boardimage-write.action")
    public String boardImageWrite(){
        return "boardImage-write";
    }

    @RequestMapping("/event.action")
    public String event(){
        return "event";
    }

    @RequestMapping("/notice.action")
    public String notice(){
        return "notice";
    }
}
