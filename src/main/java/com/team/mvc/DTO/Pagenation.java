package com.team.mvc.DTO;


public class Pagenation {
    private int pageNum;    // 페이지 번호
    private int totalPost;  // 전체 게시글 수
    private int pageSize;   // 페이지당 게시글 개수 (n개씩보기)
    private int blockSize;  // 페이지 블럭 크기

    private int totalPage;  // 전체 페이지 수
    private int startRow;   // 시작 행번호
    private int endRow;     // 종료 행번호
    private int startPage;  // 시작 페이지 번호
    private int endPage;    // 끝 페이지 번호
    private int prevPage;   // 이전 블록 페이지 번호
    private int nextPage;   // 다음 블록 페이지 번호

    // 기본 생성자
    public Pagenation() {
        this.startPage = 1;
        this.endPage = 1;
    }

    // 매개변수 생성자
    public Pagenation(int pageNum, int totalPost, int pageSize, int blockSize) {
        this.pageNum = pageNum;
        this.totalPost = totalPost;
        this.pageSize = pageSize;
        this.blockSize = blockSize;

        // 페이징 계산 메서드 호출
        calculatePaging();
    }

    // 페이징 계산 메서드
    public void calculatePaging() {
        // 전체 페이지 수 계산 (올림)
        totalPage = (int) Math.ceil((double) totalPost / pageSize);

        // 현재 페이지가 전체 페이지보다 크면 마지막 페이지로 설정
        if (pageNum > totalPage) {
            pageNum = totalPage;
        }

        // 현재 페이지가 0 이하이면 1로 설정
        if (pageNum <= 0) {
            pageNum = 1;
        }

        // 시작행과 종료행 계산
        startRow = (pageNum - 1) * pageSize + 1;
        endRow = pageNum * pageSize;

        // 시작 페이지와 종료 페이지 계산
        startPage = ((pageNum - 1) / blockSize) * blockSize + 1;
        endPage = Math.min(startPage + blockSize - 1, totalPage);

        // 이전 페이지, 다음 페이지 계산
        prevPage = startPage > 1 ? startPage - 1 : 1;
        nextPage = endPage < totalPage ? endPage + 1 : totalPage;
    }

    // getter / setter


    public int getPageNum() {
        return pageNum;
    }

    public void setPageNum(int pageNum) {
        this.pageNum = pageNum;
    }

    public int getTotalPost() {
        return totalPost;
    }

    public void setTotalPost(int totalPost) {
        this.totalPost = totalPost;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public int getBlockSize() {
        return blockSize;
    }

    public void setBlockSize(int blockSize) {
        this.blockSize = blockSize;
    }

    public int getTotalPage() {
        return totalPage;
    }

    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }

    public int getStartRow() {
        return startRow;
    }

    public void setStartRow(int startRow) {
        this.startRow = startRow;
    }

    public int getEndRow() {
        return endRow;
    }

    public void setEndRow(int endRow) {
        this.endRow = endRow;
    }

    public int getStartPage() {
        return startPage;
    }

    public void setStartPage(int startPage) {
        this.startPage = startPage;
    }

    public int getEndPage() {
        return endPage;
    }

    public void setEndPage(int endPage) {
        this.endPage = endPage;
    }

    public int getPrevPage() {
        return prevPage;
    }

    public void setPrevPage(int prevPage) {
        this.prevPage = prevPage;
    }

    public int getNextPage() {
        return nextPage;
    }

    public void setNextPage(int nextPage) {
        this.nextPage = nextPage;
    }
}
