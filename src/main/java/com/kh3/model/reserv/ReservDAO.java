package com.kh3.model.reserv;

import java.util.List;
import java.util.Map;




public interface ReservDAO {

    int getReservCount(Map<String, Object> map);	

    // 예약 전체 리스트
    List<ReservDTO> getReservList(int startNo, int endNo, Map<String, Object> map);


    // 예약 상세 내역
    ReservDTO getReservView(int reserv_no, String reserv_sess);


    // 예약 상태 변경
    int modifyReservStatus(int reserv_no, String reserv_sess, String reserv_status);


    // 예약 피크닉 날짜 변경
    int modifyReservFicnicDate(int reserv_no, String reserv_sess, String ficnic_date);

    
    // 해당 세션 예약 카운트
	int getSiteReservCount(Map<String, Object> searchMap);

	// 해당 세션 예약 카운트
	List<ReservDTO> getBoardList(int startNo, int endNo, Map<String, Object> searchMap);

	// 회원 예약내용 상세 페이지
	ReservDTO getResevCont(int reserv_no);


	// 회원 예약 리스트
	List<ReservDTO> getReservSessionList(String member_id);

	// 지난 날짜 예약 취소로 변경
	void updateReserv_status(ReservDTO val);

	// 회원 예약 하기
	int insertReserv(ReservDTO rDto);

	// 해당 날짜 Reserv-sess 중복 검사 리스트
	List<ReservDTO> getReservList(String todayDate);


	// 관리자 상단 최근 3일 예약내역 가져오기
	List<ReservDTO> getRecentReservList(String chk_date);
}
