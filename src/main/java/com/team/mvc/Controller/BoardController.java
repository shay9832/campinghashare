package com.team.mvc.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class BoardController {

    @RequestMapping("/boardmain.action")
    public String boardMain(){
        return "boardMain";
    }

    @RequestMapping("/boardbest.action")
    public String boardBest(){
        return "boardBest";
    }

    @RequestMapping("/boardfree.action")
    public String boardFree(){
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
