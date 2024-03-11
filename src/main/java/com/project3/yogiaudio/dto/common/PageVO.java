package com.project3.yogiaudio.dto.common;

public class PageVO {

	private int totalCount;  // 총 개수
	private int startPage;	 // 페이지 블럭 시작번호
	private int endPage;	 // 페이지 블럭 끝번호

	private boolean prev; 	 // 이전링크
	private boolean next;	 // 다음링크

	private int displayPageNum = 5; //페이지 블럭의 크기

	//private int page;
	//private int pageSize;
	private Criteria cri;

	// => 페이지번호, 페이지 사이즈 저장
	public void setCri(Criteria cri) {
		this.cri = cri;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		// 페이징 처리에 필요한 정보를 모두 계산
		calcData();
	}

	private void calcData() {
		// 페이징처리 정보를 모두 계산

		// 끝 페이지번호
		endPage =  (int)(Math.ceil(cri.getPage() / (double)displayPageNum)) * displayPageNum;
		// 시작 페이지번호
		startPage = (endPage - displayPageNum) + 1;

		// 끝 페이지 번호체크 (글이 없는경우)
		//int tmpEndPage = totalCount / cri.getPageSize() + (totalCount%cri.getPageSize()==0? 0:1);
		int tmpEndPage = (int)(Math.ceil(((double)totalCount / cri.getPageSize())));

		if(endPage > tmpEndPage) {
			endPage = tmpEndPage;
		}

		// 이전 링크
		prev = startPage != 1;
		//prev = startPage == 1? false:true;
		// 다음 링크
		next = endPage * cri.getPageSize() < totalCount;
		//next = endPage * cri.getPageSize() >= totalCount? false:true;

		// 페이징처리 정보를 계산완료
	} // calcData()




	public int getTotalCount() {
		return totalCount;
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

	public boolean isPrev() {
		return prev;
	}

	public void setPrev(boolean prev) {
		this.prev = prev;
	}

	public boolean isNext() {
		return next;
	}

	public void setNext(boolean next) {
		this.next = next;
	}

	public int getDisplayPageNum() {
		return displayPageNum;
	}

	public void setDisplayPageNum(int displayPageNum) {
		this.displayPageNum = displayPageNum;
	}

	public Criteria getCri() {
		return cri;
	}


	@Override
	public String toString() {
		return "PageVO [totalCount=" + totalCount + ", startPage=" + startPage + ", endPage=" + endPage + ", prev="
				+ prev + ", next=" + next + ", displayPageNum=" + displayPageNum + ", cri=" + cri + "]";
	}


}
