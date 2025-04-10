package com.team.mvc.DTO;

public class Pagenation {
    private int pageSize = 10;  // 한 페이지당 게시글 수
    private int rangeSize = 10; // 한 블럭당 페이지 수
    private int currentPage = 1; // 현재 페이지
    private int currentRange = 1; // 현재 블럭
    private int postCnt; // 총 게시글 수
    private int pageCnt; // 총 페이지 수
    private int rangeCnt; // 총 블럭 수
    private int startPage = 1;
    private int endPage = 1;
    private int startIndex = 1;
    private int prevPage;
    private int nextPage;


    public Pagenation() {

    }



}
