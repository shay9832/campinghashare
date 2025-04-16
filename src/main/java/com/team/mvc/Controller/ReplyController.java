package com.team.mvc.Controller;


import com.team.mvc.DTO.ReplyDTO;
import com.team.mvc.Interface.IReplyService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.*;


import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/reply")
public class ReplyController {

    @Autowired
    private IReplyService replyService;

    /**
     * 댓글 추가
     */
    @PostMapping("/add.action")
    public ResponseEntity<Map<String, Object>> addReply(
            @RequestBody ReplyDTO replyDTO,
            @ModelAttribute("userCode") Integer userCode) {

        Map<String, Object> response = new HashMap<>();

        try {
            // 로그인 체크
            if (userCode == null) {
                response.put("success", false);
                response.put("message", "로그인이 필요합니다.");
                return ResponseEntity.ok(response);
            }

            // 사용자 코드 설정
            replyDTO.setUserCode(userCode);

            // 댓글 추가
            int result = replyService.insertReply(replyDTO);

            if (result > 0) {
                response.put("success", true);
                response.put("message", "댓글이 등록되었습니다.");
            } else {
                response.put("success", false);
                response.put("message", "댓글 등록에 실패했습니다.");
            }
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "오류가 발생했습니다: " + e.getMessage());
        }

        return ResponseEntity.ok(response);
    }

    /**
     * 댓글 삭제
     */
    @PostMapping("/delete.action")
    public ResponseEntity<Map<String, Object>> deleteReply(
            @RequestBody Map<String, Object> requestData,
            @ModelAttribute("userCode") Integer userCode) {

        Map<String, Object> response = new HashMap<>();

        try {
            // 로그인 체크
            if (userCode == null) {
                response.put("success", false);
                response.put("message", "로그인이 필요합니다.");
                return ResponseEntity.ok(response);
            }

            // 요청 데이터에서 댓글 ID 가져오기
            int replyId = ((Number) requestData.get("replyId")).intValue();

            // 댓글 작성자 확인 (자신의 댓글만 삭제 가능)
            ReplyDTO reply = replyService.getReplyById(replyId);

            if (reply == null) {
                response.put("success", false);
                response.put("message", "댓글이 존재하지 않습니다.");
                return ResponseEntity.ok(response);
            }

            if (reply.getUserCode() != userCode) {
                response.put("success", false);
                response.put("message", "자신의 댓글만 삭제할 수 있습니다.");
                return ResponseEntity.ok(response);
            }

            // 댓글 삭제
            int result = replyService.deleteReply(replyId);

            if (result > 0) {
                response.put("success", true);
                response.put("message", "댓글이 삭제되었습니다.");
            } else {
                response.put("success", false);
                response.put("message", "댓글 삭제에 실패했습니다.");
            }
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "오류가 발생했습니다: " + e.getMessage());
        }

        return ResponseEntity.ok(response);
    }
}
