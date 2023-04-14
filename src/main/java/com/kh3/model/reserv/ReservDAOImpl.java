package com.kh3.model.reserv;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class ReservDAOImpl implements ReservDAO {

    @Inject
    private SqlSessionTemplate sqlSession;


    @Override
	public int getReservCount(Map<String, Object> searchMap) {
        return this.sqlSession.selectOne("adminReservCount", searchMap);
	}



    @Override
	public List<ReservDTO> getReservList(int startNo, int endNo, Map<String, Object> searchMap) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("startNo", startNo);
        map.put("endNo", endNo);
        map.put("search_status", searchMap.get("search_status"));
        map.put("search_date_start", searchMap.get("search_date_start"));
        map.put("search_date_end", searchMap.get("search_date_end"));
        map.put("search_sess", searchMap.get("search_sess"));
        map.put("search_ficnic", searchMap.get("search_ficnic"));
        map.put("search_name", searchMap.get("search_name"));

        return this.sqlSession.selectList("adminReservList", map);
	}
	


	// 예약 상세내역
	@Override
	public ReservDTO getReservView(int reserv_no, String reserv_sess) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("reserv_no", reserv_no);
        map.put("reserv_sess", reserv_sess);

        return this.sqlSession.selectOne("adminReservView", map);
	}



	// 예약 상태 변경
    @Override
    public int modifyReservStatus(int reserv_no, String reserv_sess, String reserv_status) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("reserv_no", reserv_no);
        map.put("reserv_sess", reserv_sess);
        map.put("reserv_status", reserv_status);

        return this.sqlSession.update("adminReservModifyStatus", map);
    }



    // 예약 피크닉 날짜 변경
    @Override
    public int modifyReservFicnicDate(int reserv_no, String reserv_sess, String ficnic_date) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("reserv_no", reserv_no);
        map.put("reserv_sess", reserv_sess);
        map.put("ficnic_date", ficnic_date);

        return this.sqlSession.update("adminReservModifyFicnicDate", map);
    }


    // 해당 세션 예약 카운트
	@Override
	public int getSiteReservCount(Map<String, Object> searchMap) {
		return this.sqlSession.selectOne("siteReservCount", searchMap);
	}



	@Override
	public List<ReservDTO> getBoardList(int startNo, int endNo, Map<String, Object> searchMap) {
		searchMap.put("startNo", startNo);
		searchMap.put("endNo", endNo);
		
		return this.sqlSession.selectList("siteReservList", searchMap);
	}



	@Override
	public ReservDTO getResevCont(int reserv_no) {
		return this.sqlSession.selectOne("siteReservCont",reserv_no );
	}



	@Override
	public List<ReservDTO> getReservSessionList(String member_id) {
		return this.sqlSession.selectList("siteReservSessionList", member_id);
	}



	@Override
	public void updateReserv_status(ReservDTO val) {
		this.sqlSession.update("siteChangeReservStatus", val);
	}



	@Override
	public int insertReserv(ReservDTO rDto) {
		return this.sqlSession.insert("siteReservFicnic", rDto);
	}



	@Override
	public List<ReservDTO> getReservList(String todayDate) {
		return this.sqlSession.selectList("siteReservCheckSessList", todayDate);
	}



    // 관리자 상단 최근 3일 예약내역 가져오기
	@Override
    public List<ReservDTO> getRecentReservList(String chk_date) {
        return this.sqlSession.selectList("adminRecentReservList", chk_date);
    }
}