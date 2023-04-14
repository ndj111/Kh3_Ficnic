<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/layout_header.jsp" %>
<c:if test="${empty sess_id}"><script type="text/javascript">alert('회원 로그인 후 참여 할 수 있습니다.'); history.back();</script></c:if>

<link type="text/css" rel="stylesheet" href="${path}/resources/site/css/css_reserv.css" />
<script language="javascript" src="${path}/resources/site/js/js_reserv.js"></script>




<div class="page-info w1100">
    <h2>참여하기</h2>
    <ol>
        <li><a href="${path}/"><i class="icon-home"></i> HOME</a></li>
        <li>피크닉</li>
        <li><b>참여하기</b></li>
    </ol>
</div>

<!-- js로 받는 값  -->
<input type="hidden"  name="price_type">
<input type="hidden"  name="price_over">
<input type="hidden"  name="price_max">
<input type="hidden"  name="date_type">
<input type="hidden"  name="date_value">
<input type="hidden"  name="start_date">
<input type="hidden"  name="end_date">
<input type="hidden"  name="coupon_price">
<input type="hidden" id="memberPoint" value="${memdto.getMember_point()}">

<div class="contents w1100 reserv-form">
<form action="${path}/ficnic/reserv_form_ok.do" method="post">
<input type="hidden" value="${fdto.getFicnic_no()}"  name="ficnic_no" />
<input type="hidden" value="${fdto.getFicnic_name()}"  name="reserv_ficnic_name" />
<input type="hidden" value="${dto.getReserv_ficnic_sale_price()}"  name="reserv_ficnic_sale_price" />
<input type="hidden" value="${dto.getReserv_ficnic_photo()}"  name="reserv_ficnic_photo" />
<input type="hidden" value="${dto.getReserv_ficnic_option_title()}"  name="reserv_ficnic_option_title" />
<input type="hidden" value="${dto.getReserv_ficnic_option_price()}"  name="reserv_ficnic_option_price" />
<input type="hidden" value="${dto.getReserv_ficnic_select_title()}"  name="reserv_ficnic_select_title" />
<input type="hidden" value="${dto.getReserv_ficnic_select_price()}"  name="reserv_ficnic_select_price" />
<input type="hidden" value="${dto.getReserv_ficnic_date()}"  name="reserv_ficnic_date" />
<input type="hidden" value="${sess_id}"  name="member_id" />
<input type="hidden" value="${sess_name}"  name="reserv_name" />
<input type="hidden" value="${sess_phone}"  name="reserv_phone" />
<input type="hidden" value="${sess_email}"  name="reserv_email" />

<c:if test="${dto.getReserv_ficnic_option_price() ne 0}">
	<c:set var="oprice" value="${dto.getReserv_ficnic_option_price()}"/>
</c:if>
<c:if test="${dto.getReserv_ficnic_option_price() eq 0}">
	<c:set var="oprice" value="${dto.getReserv_ficnic_sale_price()}"/>
</c:if>

<c:set var="sprice" value="${dto.getReserv_ficnic_select_price()}"/>
<input type="hidden" value="${oprice+sprice}" name="reserv_total_price">

<div class="ficnic-pay-main d-flex flex-column ">
	
	<div class="ficnic-pay-sub">
		<div class="mb-5">
			<div class="ficnic_pay_ficnicInfo d-flex flex-row justify-content-between mt-4">
				
					<div class="d-flex flex-row">
						<div class="mr-3">
							<img src="${path}${fdto.getFicnic_photo1()}" width="200" height="200" style=" border-radius: 5%;">
						</div>
						<div class="d-flex flex-column justify-content-between">
							<div class="ficnic_pay_ficnicTitle">
								<span>${fdto.getFicnic_name()}</span> 	
							</div>
							
							<div class="ficnic_pay_ficnicStarReview mt-2 mb-2">
								
								<div>
									<div>
										<img src="data:image/svg+xml,%3Csvg width='16' height='14' viewBox='0 0 16 14' fill='none' xmlns='http://www.w3.org/2000/svg'%3E %3Cpath d='M12.293 8.6189L15.7442 6.00968C16.2325 5.63914 15.9799 4.9135 15.3402 4.88263L10.8957 4.6356C10.6263 4.62016 10.3906 4.46577 10.2896 4.23418L8.65658 0.405277C8.42088 -0.135092 7.59595 -0.135092 7.36026 0.405277L5.72724 4.21874C5.62623 4.45033 5.39053 4.60472 5.12117 4.62016L0.659819 4.86719C0.0200779 4.89806 -0.232451 5.6237 0.255772 5.99424L3.707 8.58802C3.90903 8.74241 4.01004 9.00487 3.9427 9.23646L2.81473 13.2043C2.66322 13.7601 3.31979 14.2079 3.85852 13.8991L7.61279 11.6913C7.84848 11.5523 8.13468 11.5523 8.35354 11.6913L12.1246 13.8991C12.6634 14.2079 13.3199 13.7601 13.1684 13.2043L12.0405 9.2519C11.99 9.02031 12.0741 8.77329 12.293 8.6189Z' fill='%237A29FA'/%3E %3C/svg%3E" alt="별점 아이콘">
										<span class="ficnic_pay_ficnicStar">${fdto.getFicnic_review_point()}</span>
										<p class="ficnic_pay_ficnicReview">리뷰 수 : ${fdto.getFicnic_review_count()}</p>
									</div>

								</div>
							</div>
						</div>
					</div>
					
					<div class="d-flex flex-column justify-content-between mr-3">
						<div>
							<div>옵션정보</div>
							<div class="ficnic_pay_ficnicOption d-flex flex-column">
								<div>
									<div>
										<c:if test="${!empty dto.getReserv_ficnic_date() }">
										<span>예약날짜 - ${dto.getReserv_ficnic_date() }</span>
										</c:if>
										<c:if test="${empty dto.getReserv_ficnic_date() }">
										<span>예약날짜 - 이용권</span>
										</c:if>
									</div>
									<div>
										<span>선택 피크닉 - ${dto.getReserv_ficnic_option_title()}</span>
									</div>
									<c:if test="${!empty dto.getReserv_ficnic_select_title() }">
										<div>
										<span>${dto.getReserv_ficnic_select_title() }</span>
										</div>
									</c:if>
								</div>
							</div>
						</div>
						<div class="d-flex flex-row justify-content-between align-items-center">
								<p class="ficnic_pay_ficnicOption mr-2">피크닉 금액</p>
								<b class="ficnic_pay_ficnicOption"><span class="fincnic_pay_price dxsibZ" id="orginPirceView"><fmt:formatNumber value="${oprice + sprice }"/></span>원</b>
							</div>
					</div>
				
			</div>
		</div>
		<hr class="Hr-sc-1533uvg-0 cbobBO">
		<div class="mt-4 mb-2">
			<p class="ficnic_pay_ficnicTitle ">결제수단</p>
			<div class="form-check mt-2 mb-2">
			  <label class="ficnic_pay_ficnicPay">
			  	<input class="ficnic_pay_ficnicPay mr-2" id="ficnicPay_check" type="radio" name="reserv_payment2"  value="card" checked>신용/체크 카드
			  </label>
			</div>
			<div class="form-check mt-2 mb-2">
			  <label class="ficnic_pay_ficnicPay">
			  	<input class="ficnic_pay_ficnicPay mr-2" type="radio" name="reserv_payment2" data-bs-toggle="modal" data-bs-target="#exampleModal" >다른 결제수단
			  </label>
			</div>
			<div class="ficnic_pay_ficnicOtherpay ml-4">
			
			</div>

	</div>
		<hr>
		<div class="mt-4 mb-2">
			<div>
				<div>
					<p class="ficnic_pay_ficnicTitle SubTitle-eeu9i7-0 gVXCTF mt-2 mb-2">피크닉 할인 쿠폰</p>
					<div class="d-flex flex-row justify-content-between ">
						<div class="ficnic_pay_ficnicPay Coupon__CouponCount-p6h1sc-1 cRGbZm"><span>전체 ${couponCount}장</span></div>
						<select id="ficnicCouponSelect" name="select_coupon">
						<option value="">미선택</option>
						<c:if test="${!empty mlist }">
							<c:forEach items="${mlist }" var="mdto">
								<c:forEach items="${mdto.getCoupon_list() }" var="cdto" >							
									<c:if test="${mdto.getCoupon_no() eq cdto.getCoupon_no()}">
									
									<c:set value="disabled class =\"coupongray\" " var="chkabled" />		
										
										<c:if test="${cdto.getCoupon_use_type() ne 'cart' and  cdto.getCoupon_use_type() eq 'category'}" >
											<c:forTokens items="${cdto.getCoupon_use_value() }" var="val" delims="★">
													<c:if test="${fdto.getFicnic_category_no() eq val or fdto.getFicnic_category_sub1() eq val or fdto.getFicnic_category_sub2() eq val or fdto.getFicnic_category_sub3() eq val}">
													
														<c:set value="" var="chkabled" />
													</c:if>
												
											</c:forTokens>
										</c:if>
										<c:if test="${cdto.getCoupon_use_type() ne 'cart' and  cdto.getCoupon_use_type() eq 'goods'}" >
											<c:forTokens items="${cdto.getCoupon_use_value() }" var="val" delims="★">
												
													<c:if test="${fdto.getFicnic_no() eq val}">
														<c:set value="" var="chkabled" />
													</c:if>
												
											</c:forTokens>
										</c:if>		
										<c:if test="${cdto.getCoupon_use_type() eq 'cart'}" >
											<c:set value="" var="chkabled" />
										</c:if>			
										<option  ${chkabled} value="${cdto.getCoupon_no()}" ><c:if test="${chkabled ne '' }">[사용불가]</c:if>${cdto.getCoupon_name()} [${cdto.getCoupon_price()}<c:if test="${cdto.getCoupon_price_type() ne 'price' }">% 할인</c:if><c:if test="${cdto.getCoupon_price_type() eq 'price' }">원 할인</c:if>]</option>									
									</c:if>	
									
								</c:forEach>	
							</c:forEach>
						</c:if>
						</select>
					</div>
					<hr class="Hr-sc-4qqq6q-0 bqjyoQ">
					<p class="ficnic_pay_ficnicTitle  gVXCTF mt-2 mb-2">적립금 사용</p>
					<div class="d-flex flex-column">
							<div class="d-flex flex-row justify-content-between">
								<span class="ficnic_pay_ficnicPay">보유한 적립금</span>
								<span>${memdto.getMember_point()}원</span>
							</div>
							<div class="d-flex flex-row justify-content-between">
								<span class="ficnic_pay_ficnicPay">사용할 적립금</span>
								<input type="number" min="0" max="${memdto.getMember_point()}" value="0" step="100" onpause="NumberInput(this)" name="canUsePoint" >
							</div>
					</div>
				</div>
			</div>
		</div>
		<hr class="Hr-sc-1533uvg-0 cbobBO">
		<div class="mt-4">
			
			<div class="d-flex flex-row justify-content-between">
				<p class="ficnic_pay_ficnicTitle TotalPrice__PriceSectionSubTitle-sc-1e1zxsm-2 eHKVGS">총 피크닉 금액</p>
				<b class="fincnic_pay_price"><span class="fincnic_pay_price" id="sitePriceView">${oprice + sprice}</span>원</b>
			</div>
		</div>
		<div class="bg-light d-flex flex-column mt-4">
			<div class="d-flex flex-row justify-content-between m-2">
				<p class="ficnic_pay_ficnicPay">개인정보 제 3자 제공약관</p> <button class="btn" type="button" data-bs-toggle="collapse" data-bs-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample">보기</button>
			</div>
			<div class="collapse" id="collapseExample">
				  <div class="card card-body">
				   <span><pre>개인정보 제 3자 제공 동의

개인정보처리방침
개인정보 수집 및 이용 안내
주식회사 피크닉트립(이하 “회사”)는 회원님의 개인정보를 보호하기 위해 최선을 다하고 있습니다. 이를 위해서 회사는 개인정보의 보호와 관련하여 ‘정보통신망 이용촉진 및 정보보호 등에 관한 법률’, ‘개인정보 보호법’ 등 개인정보와 관련된 법령을 준수하고 있습니다.
1. 수집하는 개인정보의 항목
회사는 이름, 이메일, 나이, 성별, 서비스 이용기록, 결제 및 환불 기록, 생년월일, 휴대폰번호, 관심분야 등에 관한 정보를 수집합니다.
서비스를 이용하는 과정에서 방문일시, 사용이력, 기기정보, 접속로그, IP주소 등이 자동으로 생성·수집 될 수 있습니다.
회사는 회원가입, 구매 등 서비스 제공을 위한 최소한의 범위 내에서 이용자의 동의 하에 개인정보를 수집하며, 수집한 모든 개인정보는 고지한 목적 범위 내에서만 이용됩니다.
1) 회원 가입 시
- (필수) 아이디(E-MAIL), 비밀번호, 휴대폰번호, 닉네임
- (선택) 생년월일, 성별, 연계정보(CI)
2) 판매 회원 가입 시
- (필수) 호스트명, 이름, 아이디, 비밀번호, E-MAIL, 사업자등록번호, 주민등록증, 담당자 이름, 휴대폰번호, 주소, 호스트 약력, 은행명, 예금주, 계좌번호
- (선택) 호스트등록경로, 프로필 사진
3) 상품 구매 시
- (필수) 핸드폰번호, 신용카드 정보, 은행계좌 정보, 결제기록 등의 정보
- (선택) 배송지 정보: 수령인, 연락처, 주소지
- (선택) 탑승자 이름, 동반인정보(성명, 이외 서비스의 유형에 따라, 추가적인 정보가 수집될 수 있습니다. (여행상품)
4) 모바일 사용 시
- 피크닉 앱 버전, OS버전 (iOS, 안드로이드)
- 위치정보 (별도 저장없이 앱에서 사용)
5) 기타
- 서비스 이용과정에서 자동 수집 정보 : 회원ID, IP Address, 쿠키, 방문 일시, 서비스 이용 기록, 불량 이용 기록, 기기정보, ADID, IDFA, 위치정보
-고객 분쟁처리 및 상담 진행 시 : 상담내역, 채팅(대화)내역, 서비스 이용기록, 결제 및 환불 기록
6) 구독회원
- E-MAIL, 성별

2. 개인정보의 수집 및 이용목적
회사는 회원의 식별·확인, 회원가입 의사 확인, 중복가입 여부 확인, 만14세 미만 여부 확인, 법정대리인의 동의 처리, 계약의 체결·이행·관리, 주문상품의 배송 상태 통지, 결제 및 환불, 통계분석, 구매 성향 분석, 서비스 개선, 민원 기타 문의 사항 처리, 부정이용에 대한 조사 및 대응, 고지사항 전달, 청구서 등의 발송, 법령상 의무 이행, 사은/판촉행사 등 각종 이벤트, 개인 맞춤형 서비스 제공, 새로운 상품 기타 행사 관련 정보 안내 및 마케팅 활동, 이메일 초대권 활용 내역 조회, 회사 및 제휴사 상품/서비스 안내 및 권유의 목적으로 개인정보를 이용합니다.

3. 개인정보 수집 방법
회사는 홈페이지, 어플리케이션, 고객센터, 게시판, 이벤트 참여, 제휴사로부터의 전달 등을 통해 개인정보를 수집합니다. 이용자는 회사가 마련한 개인정보 처리 동의서에 대해 「동의」 버튼을 클릭함으로써 개인정보 처리에 대하여 동의 여부를 표시할 수 있습니다.

4. 개인정보의 보유 및 이용기간
귀하가 제공한 개인정보는 법령에서 별도로 정하거나 귀하와 별도 합의하는 등의 특별한 사정이 없는 한 회사가 제공하는 서비스를 받는 동안 또는 위에서 정한 목적을 달성할 때까지 회사가 보유ㆍ이용하게 됩니다.
회사는 관련 법령(아래의 경우에 한정되지 않습니다)의 규정에 의하여 보존하여야 하는 기록은 일정 기간 보관 후 파기합니다.
가. 계약 또는 청약철회 등에 관한 기록 (보존기간 : 5년) : 전자상거래 등에서의 소비자 보호에 관한 법률
나. 대금결제 및 재화 등의 공급에 관한 기록 (보존기간 : 5년) : 전자상거래 등에서의 소비자 보호에 관한 법률
다. 소비자의 불만 또는 분쟁처리에 관한 기록 (보존기간 : 3년) : 전자상거래 등에서의 소비자 보호에 관한 법률
라. 홈페이지 방문에 관한 기록 (보존 기간: 3개월) : 통신비밀보호법

5. 개인정보 제 3자 제공
회사는 계약의 이행을 위하여 최소한의 개인정보만 제공하고 있으며, 개인정보를 제3자에게 제공해야 하는 경우 사전에 이용자에게 해당 사실을 알리고 동의를 구하도록 하겠습니다. 다만 다음의 경우는 예외로 하고 있습니다.
가. 서비스 제공에 따른 요금정산을 위해 필요한 경우
나. 법령의 규정에 의한 경우
다. 수사 목적으로 법령에 정해진 절차와 방법에 따라 수사기관의 요구가 있는 경우
회사가 제공하는 서비스를 통하여 주문 및 결제가 이루어진 경우 상담 등 거래 당사자간 원활한 의사소통 및 발송 등 거래이행을 위하여 관련된 정보를 필요한 범위 내에서 거래 당사자에게 제공합니다.

제공받는 자 : 호스트
제공하는 항목 : 이름, 성별, 나이, 연락처, 의류 사이즈, 배송지 정보(수령인, 연락처, 주소지) 등 개별 프로그램별로 필요하여 회원이 입력한 정보
제공받는 자의 이용목적 : 본인 확인, 프로그램 준비 및 이행, 민원처리, 상품(서비스), 발송(전송), 제품 설치, 반품, 환불, 고객상담 등 정보통신서비스제공계약 및 전자상거래(통신판매) 계약의 이행을 위해 필요한 업무
보유 및 이용기간 : 상품 제공 완료 후 6개월

제공받는 자 : 회원
제공하는 항목 : 호스트명, 이름, 연락처, 주소, 집결지 등 호스트가 입력한 정보
제공받는 자의 이용목적 : 본인 확인, 프로그램 준비 및 이행, 민원처리, 상품(서비스), 발송(전송), 제품 설치, 반품, 환불, 고객상담 등 정보통신서비스제공계약 및 전자상거래(통신판매) 계약의 이행을 위해 필요한 업무
보유 및 이용기간 : 상품 제공 완료 후 6개월

6. 개인정보의 처리 위탁
회사는 서비스 향상을 위해서 아래와 같이 개인정보를 위탁하고 있으며, 관계 법령에 따라 위탁계약 시 개인정보가 안전하게 관리될 수 있도록 필요한 사항을 규정하고 있습니다. 수탁자 및 수탁업무 내용은 아래와 같습니다.

수탁자 : 나이스페이, 다날, 아임포트, 페이코, 토스
수탁업무 : 결제

수탁자 : 다날
수탁업무 : 본인확인

수탁자 : braze
수탁업무 : 마케팅 자동화 솔루션

수탁자 : Sendbird
수탁업무 : 고객 상담(대화 내용)

7. 이용자의 권리
회사는 이용자(만 14세 미만자인 경우에는 법정대리인)의 권리를 다음과 같이 보호하고 있습니다.
가. 이용자는 언제든지 자신의 개인정보 또는 법정대리인의 경우 만 14세 미만자의 개인정보를 조회하고 수정하는 등 법령이 정한 권리를 행사할 수 있습니다.
나. 이용자는 언제든지 개인정보 처리의 정지를 요청할 수 있으며, 법률에 특별한 규정이 있는 등의 경우에는 처리정지 요청을 거부할 수 있습니다.
다. 이용자는 언제든지 ‘회원탈퇴’등을 통해 개인정보의 수집 및 이용 동의를 철회할 수 있습니다.
라. 개인정보의 수정을 요청하는 경우 회사는 정확한 개인정보의 이용 및 제공을 위해 수정이 완료될 때까지 이용자의 개인정보는 이용하거나 제공하지 않습니다.

8. 개인정보 파기절차 및 방법
회사는 원칙적으로 이용자의 개인정보를 회원 탈퇴 시 지체없이 파기하고 있습니다.
단, 4. 개인정보의 보유 및 이용기간에 따라 이용자에게 개인정보 보관기간에 대해 별도의 동의를 얻은 경우, 또는 법령에서 일정 기간 정보보관 의무를 부과하는 경우에는 해당 기간 동안 개인정보를 안전하게 보관합니다.
회원탈퇴, 서비스 종료, 이용자에게 동의받은 개인정보 보유기간의 도래와 같이 개인정보의 수집 및 이용목적이 달성된 개인정보는 재생이 불가능한 방법으로 파기하고 있습니다. 법령에서 보존의무를 부과한 정보에 대해서도 해당 기간 경과 후 지체없이 재생이 불가능한 방법으로 파기합니다.
전자적 파일 형태의 경우 복구 및 재생이 되지 않도록 기술적인 방법을 이용하여 안전하게 삭제하며, 출력물 등은 분쇄하거나 소각하는 방식 등으로 파기합니다.

9. 개인정보보호를 위한 기술적·관리적 조치
회사는 이용자의 개인정보를 처리함에 있어 정보의 분실, 도난, 누출, 외부로부터의 공격, 해킹 등을 방지하고 최상의 안전성을 확보하기 위하여 다음 각호의 방식을 포함하여 법령에서 정한 보호조치를 취하고 있습니다.
가. 이용자의 개인정보는 비밀번호에 의해 보호되며, 파일 및 전송 데이터를 암호화하여 중요한 데이터는 별도의 보안기능을 통해 보호되고 있습니다.
나. 회사는 컴퓨터 바이러스에 의한 피해가 발생하지 않도록 백신프로그램을 이용하고 있으며, 백신프로그램에 대한 주기적인 업데이트하고 있습니다.
다. 회사는 암호 알고리즘을 이용하여 네트워크 상의 개인정보를 안전하게 전송할 수 있는 보안장치를 채택하고 있습니다.
라. 해킹 등에 의해 이용자의 개인정보가 유출되는 것을 방지하기 위해, 외부침입을 차단하는 보안장치를 이용하고 있으며, 침입탐지시스템을 설치하여 불법적인 침입을 감시하고 있습니다.
마. 이용자의 개인정보를 처리하는 담당인원을 최소한으로 제한하며, 관련 직원에 대해서는 지속적인 보안교육의 실시와 함께 본 정책의 준수여부를 수시로 점검하고 있습니다.

10. 개인정보 자동 수집 장치의 설치/운영 및 거부에 관한 사항
회사는 이용자의 정보를 자동으로 저장하고 찾아내는 ‘쿠키(cookie)’ 등을 운용합니다. 쿠키란 웹사이트를 운영하는데 이용되는 서버가 귀하의 브라우저에 보내는 아주 작은 텍스트 파일로서 귀하의 컴퓨터 하드디스크에 저장됩니다.
가. 쿠키 등 사용 목적
로그인 식별/고객님의 사용 기록/기존 홈페이지 방문 또는 앱 사용 회수 파악 등을 통한 개인 맞춤 서비스 제공 등을 위해 쿠키를 운용합니다. 이용자는 쿠키 설치에 대한 선택권을 가지고 있습니다.
나. 쿠키 설정 거부 방법
쿠키 설정을 거부하는 방법으로는 회원님이 사용하시는 앱이나 웹 브라우저의 옵션을 선택함으로써 모든 쿠키를 허용하거나 쿠키를 저장할 때마다 확인을 거치거나, 모든 쿠키의 저장을 거부할 수 있습니다.

11. 홈페이지 개인정보 보호책임자
회사는 이용자의 개인정보에 대한 개인정보 보호책임자를 지정하여 개인정보보호를 위해 최선을 다하겠습니다. 현재 회사의 개인정보 보호책임자는 아래와 같습니다.
- 성명 : 양사열
- 소속 : 서비스개발팀
- 직위 : CTO
- E-mail : cs@frientrip.com
- 연락처 : 02-512-3662

개인정보침해에 대한 신고나 상담이 필요하신 경우에는 아래 기관에 문의하시기 바랍니다.
▶ 개인정보 침해신고센터
- 홈페이지 : privacy.kisa.or.kr
- 연락처 : (국번없이) 118, privacy@kisa.or.kr
- 주소 : (05717) 서울시 송파구 중대로 135 (가락동 78) IT벤처타워 한국인터넷진흥원 개인정보침해신고센터
▶ 대검찰청 사이버범죄수사단 : 02-3480-3573 (www.spo.go.kr)
▶ 경찰청 사이버안전국 : (경찰청 대표)182 (www.netan.go.kr)

12. 개인정보처리방침의 적용 제외
회사는 이용자에게 홈페이지를 통하여 다른 회사의 웹사이트 또는 자료에 대한 링크를 제공할 수 있습니다. 이 경우 회사는 외부사이트 및 자료에 대하여 통제권이 없을 뿐만 아니라 이들이 개인정보를 수집하는 행위에 대하여 회사의 '개인정보처리방침'이 적용되지 않습니다. 따라서, 회사가 포함하고 있는 링크를 클릭하여 타 사이트의 페이지로 이동할 경우에는 새로 방문한 사이트의 개인정보처리방침을 반드시 확인하시기 바랍니다.

13. 시행시기
본 개인정보처리방침은 2022년 7월 1일부터 시행됩니다.</pre></span>
				  </div>
				</div>
			<div class="d-flex flex-row justify-content-between m-2"> 
				<p class="ficnic_pay_ficnicPay">결제 대행 서비스 이용약관</p> <button class="btn" type="button" data-bs-toggle="collapse" data-bs-target="#collapseExample2" aria-expanded="false" aria-controls="collapseExample2" >보기</button>
			</div>
			<div class="collapse" id="collapseExample2">
			  <div class="card card-body">
			    <span><pre>
결제 대행 서비스 이용약관

개인정보처리방침

개인정보 수집 및 이용 안내
주식회사 피크닉트립(이하 “회사”)는 회원님의 개인정보를 보호하기 위해 최선을 다하고 있습니다. 이를 위해서 회사는 개인정보의 보호와 관련하여 ‘정보통신망 이용촉진 및 정보보호 등에 관한 법률’, ‘개인정보 보호법’ 등 개인정보와 관련된 법령을 준수하고 있습니다.

1. 수집하는 개인정보의 항목
회사는 이름, 이메일, 나이, 성별, 서비스 이용기록, 결제 및 환불 기록, 생년월일, 휴대폰번호, 관심분야 등에 관한 정보를 수집합니다.
서비스를 이용하는 과정에서 방문일시, 사용이력, 기기정보, 접속로그, IP주소 등이 자동으로 생성·수집 될 수 있습니다.
회사는 회원가입, 구매 등 서비스 제공을 위한 최소한의 범위 내에서 이용자의 동의 하에 개인정보를 수집하며, 수집한 모든 개인정보는 고지한 목적 범위 내에서만 이용됩니다.
1) 회원 가입 시
- (필수) 아이디(E-MAIL), 비밀번호, 휴대폰번호, 닉네임
- (선택) 생년월일, 성별, 연계정보(CI)
2) 판매 회원 가입 시
- (필수) 호스트명, 이름, 아이디, 비밀번호, E-MAIL, 사업자등록번호, 주민등록증, 담당자 이름, 휴대폰번호, 주소, 호스트 약력, 은행명, 예금주, 계좌번호
- (선택) 호스트등록경로, 프로필 사진
3) 상품 구매 시
- (필수) 핸드폰번호, 신용카드 정보, 은행계좌 정보, 결제기록 등의 정보
- (선택) 배송지 정보: 수령인, 연락처, 주소지
- (선택) 탑승자 이름, 동반인정보(성명, 이외 서비스의 유형에 따라, 추가적인 정보가 수집될 수 있습니다. (여행상품)
4) 모바일 사용 시
- 피크닉 앱 버전, OS버전 (iOS, 안드로이드)
- 위치정보 (별도 저장없이 앱에서 사용)
5) 기타
- 서비스 이용과정에서 자동 수집 정보 : 회원ID, IP Address, 쿠키, 방문 일시, 서비스 이용 기록, 불량 이용 기록, 기기정보, ADID, IDFA, 위치정보
-고객 분쟁처리 및 상담 진행 시 : 상담내역, 채팅(대화)내역, 서비스 이용기록, 결제 및 환불 기록
6) 구독회원
- E-MAIL, 성별

2. 개인정보의 수집 및 이용목적
회사는 회원의 식별·확인, 회원가입 의사 확인, 중복가입 여부 확인, 만14세 미만 여부 확인, 법정대리인의 동의 처리, 계약의 체결·이행·관리, 주문상품의 배송 상태 통지, 결제 및 환불, 통계분석, 구매 성향 분석, 서비스 개선, 민원 기타 문의 사항 처리, 부정이용에 대한 조사 및 대응, 고지사항 전달, 청구서 등의 발송, 법령상 의무 이행, 사은/판촉행사 등 각종 이벤트, 개인 맞춤형 서비스 제공, 새로운 상품 기타 행사 관련 정보 안내 및 마케팅 활동, 이메일 초대권 활용 내역 조회, 회사 및 제휴사 상품/서비스 안내 및 권유의 목적으로 개인정보를 이용합니다.

3. 개인정보 수집 방법
회사는 홈페이지, 어플리케이션, 고객센터, 게시판, 이벤트 참여, 제휴사로부터의 전달 등을 통해 개인정보를 수집합니다. 이용자는 회사가 마련한 개인정보 처리 동의서에 대해 「동의」 버튼을 클릭함으로써 개인정보 처리에 대하여 동의 여부를 표시할 수 있습니다.

4. 개인정보의 보유 및 이용기간
귀하가 제공한 개인정보는 법령에서 별도로 정하거나 귀하와 별도 합의하는 등의 특별한 사정이 없는 한 회사가 제공하는 서비스를 받는 동안 또는 위에서 정한 목적을 달성할 때까지 회사가 보유ㆍ이용하게 됩니다.
회사는 관련 법령(아래의 경우에 한정되지 않습니다)의 규정에 의하여 보존하여야 하는 기록은 일정 기간 보관 후 파기합니다.
가. 계약 또는 청약철회 등에 관한 기록 (보존기간 : 5년) : 전자상거래 등에서의 소비자 보호에 관한 법률
나. 대금결제 및 재화 등의 공급에 관한 기록 (보존기간 : 5년) : 전자상거래 등에서의 소비자 보호에 관한 법률
다. 소비자의 불만 또는 분쟁처리에 관한 기록 (보존기간 : 3년) : 전자상거래 등에서의 소비자 보호에 관한 법률
라. 홈페이지 방문에 관한 기록 (보존 기간: 3개월) : 통신비밀보호법

5. 개인정보 제 3자 제공
회사는 계약의 이행을 위하여 최소한의 개인정보만 제공하고 있으며, 개인정보를 제3자에게 제공해야 하는 경우 사전에 이용자에게 해당 사실을 알리고 동의를 구하도록 하겠습니다. 다만 다음의 경우는 예외로 하고 있습니다.
가. 서비스 제공에 따른 요금정산을 위해 필요한 경우
나. 법령의 규정에 의한 경우
다. 수사 목적으로 법령에 정해진 절차와 방법에 따라 수사기관의 요구가 있는 경우
회사가 제공하는 서비스를 통하여 주문 및 결제가 이루어진 경우 상담 등 거래 당사자간 원활한 의사소통 및 발송 등 거래이행을 위하여 관련된 정보를 필요한 범위 내에서 거래 당사자에게 제공합니다.

제공받는 자 : 호스트
제공하는 항목 : 이름, 성별, 나이, 연락처, 의류 사이즈, 배송지 정보(수령인, 연락처, 주소지) 등 개별 프로그램별로 필요하여 회원이 입력한 정보
제공받는 자의 이용목적 : 본인 확인, 프로그램 준비 및 이행, 민원처리, 상품(서비스), 발송(전송), 제품 설치, 반품, 환불, 고객상담 등 정보통신서비스제공계약 및 전자상거래(통신판매) 계약의 이행을 위해 필요한 업무
보유 및 이용기간 : 상품 제공 완료 후 6개월

제공받는 자 : 회원
제공하는 항목 : 호스트명, 이름, 연락처, 주소, 집결지 등 호스트가 입력한 정보
제공받는 자의 이용목적 : 본인 확인, 프로그램 준비 및 이행, 민원처리, 상품(서비스), 발송(전송), 제품 설치, 반품, 환불, 고객상담 등 정보통신서비스제공계약 및 전자상거래(통신판매) 계약의 이행을 위해 필요한 업무
보유 및 이용기간 : 상품 제공 완료 후 6개월

6. 개인정보의 처리 위탁
회사는 서비스 향상을 위해서 아래와 같이 개인정보를 위탁하고 있으며, 관계 법령에 따라 위탁계약 시 개인정보가 안전하게 관리될 수 있도록 필요한 사항을 규정하고 있습니다. 수탁자 및 수탁업무 내용은 아래와 같습니다.

수탁자 : 나이스페이, 다날, 아임포트, 페이코, 토스
수탁업무 : 결제

수탁자 : 다날
수탁업무 : 본인확인

수탁자 : braze
수탁업무 : 마케팅 자동화 솔루션

수탁자 : Sendbird
수탁업무 : 고객 상담(대화 내용)

7. 이용자의 권리
회사는 이용자(만 14세 미만자인 경우에는 법정대리인)의 권리를 다음과 같이 보호하고 있습니다.
가. 이용자는 언제든지 자신의 개인정보 또는 법정대리인의 경우 만 14세 미만자의 개인정보를 조회하고 수정하는 등 법령이 정한 권리를 행사할 수 있습니다.
나. 이용자는 언제든지 개인정보 처리의 정지를 요청할 수 있으며, 법률에 특별한 규정이 있는 등의 경우에는 처리정지 요청을 거부할 수 있습니다.
다. 이용자는 언제든지 ‘회원탈퇴’등을 통해 개인정보의 수집 및 이용 동의를 철회할 수 있습니다.
라. 개인정보의 수정을 요청하는 경우 회사는 정확한 개인정보의 이용 및 제공을 위해 수정이 완료될 때까지 이용자의 개인정보는 이용하거나 제공하지 않습니다.

8. 개인정보 파기절차 및 방법
회사는 원칙적으로 이용자의 개인정보를 회원 탈퇴 시 지체없이 파기하고 있습니다.
단, 4. 개인정보의 보유 및 이용기간에 따라 이용자에게 개인정보 보관기간에 대해 별도의 동의를 얻은 경우, 또는 법령에서 일정 기간 정보보관 의무를 부과하는 경우에는 해당 기간 동안 개인정보를 안전하게 보관합니다.
회원탈퇴, 서비스 종료, 이용자에게 동의받은 개인정보 보유기간의 도래와 같이 개인정보의 수집 및 이용목적이 달성된 개인정보는 재생이 불가능한 방법으로 파기하고 있습니다. 법령에서 보존의무를 부과한 정보에 대해서도 해당 기간 경과 후 지체없이 재생이 불가능한 방법으로 파기합니다.
전자적 파일 형태의 경우 복구 및 재생이 되지 않도록 기술적인 방법을 이용하여 안전하게 삭제하며, 출력물 등은 분쇄하거나 소각하는 방식 등으로 파기합니다.

9. 개인정보보호를 위한 기술적·관리적 조치
회사는 이용자의 개인정보를 처리함에 있어 정보의 분실, 도난, 누출, 외부로부터의 공격, 해킹 등을 방지하고 최상의 안전성을 확보하기 위하여 다음 각호의 방식을 포함하여 법령에서 정한 보호조치를 취하고 있습니다.
가. 이용자의 개인정보는 비밀번호에 의해 보호되며, 파일 및 전송 데이터를 암호화하여 중요한 데이터는 별도의 보안기능을 통해 보호되고 있습니다.
나. 회사는 컴퓨터 바이러스에 의한 피해가 발생하지 않도록 백신프로그램을 이용하고 있으며, 백신프로그램에 대한 주기적인 업데이트하고 있습니다.
다. 회사는 암호 알고리즘을 이용하여 네트워크 상의 개인정보를 안전하게 전송할 수 있는 보안장치를 채택하고 있습니다.
라. 해킹 등에 의해 이용자의 개인정보가 유출되는 것을 방지하기 위해, 외부침입을 차단하는 보안장치를 이용하고 있으며, 침입탐지시스템을 설치하여 불법적인 침입을 감시하고 있습니다.
마. 이용자의 개인정보를 처리하는 담당인원을 최소한으로 제한하며, 관련 직원에 대해서는 지속적인 보안교육의 실시와 함께 본 정책의 준수여부를 수시로 점검하고 있습니다.

10. 개인정보 자동 수집 장치의 설치/운영 및 거부에 관한 사항
회사는 이용자의 정보를 자동으로 저장하고 찾아내는 ‘쿠키(cookie)’ 등을 운용합니다. 쿠키란 웹사이트를 운영하는데 이용되는 서버가 귀하의 브라우저에 보내는 아주 작은 텍스트 파일로서 귀하의 컴퓨터 하드디스크에 저장됩니다.
가. 쿠키 등 사용 목적
로그인 식별/고객님의 사용 기록/기존 홈페이지 방문 또는 앱 사용 회수 파악 등을 통한 개인 맞춤 서비스 제공 등을 위해 쿠키를 운용합니다. 이용자는 쿠키 설치에 대한 선택권을 가지고 있습니다.
나. 쿠키 설정 거부 방법
쿠키 설정을 거부하는 방법으로는 회원님이 사용하시는 앱이나 웹 브라우저의 옵션을 선택함으로써 모든 쿠키를 허용하거나 쿠키를 저장할 때마다 확인을 거치거나, 모든 쿠키의 저장을 거부할 수 있습니다.

11. 홈페이지 개인정보 보호책임자
회사는 이용자의 개인정보에 대한 개인정보 보호책임자를 지정하여 개인정보보호를 위해 최선을 다하겠습니다. 현재 회사의 개인정보 보호책임자는 아래와 같습니다.
- 성명 : 아무개
- 소속 : 서비스개발팀
- 직위 : 없음
- E-mail : aMugae@frientrip.com
- 연락처 : 0101-1234-1234

개인정보침해에 대한 신고나 상담이 필요하신 경우에는 아래 기관에 문의하시기 바랍니다.
▶ 개인정보 침해신고센터
- 홈페이지 : privacy.kisa.or.kr
- 연락처 : (국번없이) 118, privacy@kisa.or.kr
- 주소 : (05717) 서울시 송파구 중대로 135 (가락동 78) IT벤처타워 한국인터넷진흥원 개인정보침해신고센터
▶ 대검찰청 사이버범죄수사단 : 02-3480-3573 (www.spo.go.kr)
▶ 경찰청 사이버안전국 : (경찰청 대표)182 (www.netan.go.kr)

12. 개인정보처리방침의 적용 제외
회사는 이용자에게 홈페이지를 통하여 다른 회사의 웹사이트 또는 자료에 대한 링크를 제공할 수 있습니다. 이 경우 회사는 외부사이트 및 자료에 대하여 통제권이 없을 뿐만 아니라 이들이 개인정보를 수집하는 행위에 대하여 회사의 '개인정보처리방침'이 적용되지 않습니다. 따라서, 회사가 포함하고 있는 링크를 클릭하여 타 사이트의 페이지로 이동할 경우에는 새로 방문한 사이트의 개인정보처리방침을 반드시 확인하시기 바랍니다.

13. 시행시기
본 개인정보처리방침은 2022년 7월 1일부터 시행됩니다.
			    </pre>
			    </span>
			  </div>
			</div>	
		</div>
		<hr>
		
		<div class="d-flex flex-column mt-4">
			<strong class="ficnic_pay_ficnicPay mt-2 mb-3">이번 피크닉은 누구와 하시나요?</strong>
			<span class="ficnic_pay_ficnicPay mt-2 mb-2">다음번 크루님이 좋아할만한 피크닉을 추천해드릴게요.</span>
			<div class="form-check form-check-inline mt-3">
			  <input class="form-check-input" type="radio" id="inlineCheckbox1" value="single" name="reserv_with" checked>
			  <label class="ficnic_pay_ficnicPay form-check-label mr-2" for="inlineCheckbox1">혼자</label>

			  <input class="ficnic_pay_ficnicPay form-check-input" type="radio" id="inlineCheckbox2" value="couple" name="reserv_with">
			  <label class="ficnic_pay_ficnicPay form-check-label mr-2" for="inlineCheckbox2">연인</label>
						
			  <input class="form-check-input" type="radio" id="inlineCheckbox3" value="friend" name="reserv_with">
			  <label class="ficnic_pay_ficnicPay form-check-label mr-2" for="inlineCheckbox3">친구</label>
			
			  <input class="form-check-input" type="radio" id="inlineCheckbox4" value="family" name="reserv_with">
			  <label class="ficnic_pay_ficnicPay form-check-label mr-2" for="inlineCheckbox4">가족</label>
			
			  <input class="form-check-input" type="radio" id="inlineCheckbox5" value="parent" name="reserv_with">
			  <label class="ficnic_pay_ficnicPay form-check-label mr-2" for="inlineCheckbox5">배우자</label>
			</div>
		</div>
		
		<div class="d-flex flex-row  justify-content-center mt-5 mb-2 ">
			<p>위 내용을 모두 확인하였으며, 해당 피크닉을 예약합니다.<p>
		</div>
		
		</div>
		<div class="d-flex flex-row  justify-content-center mt-3 mb-2 w100">
			<input class="btn w-100 text-white py-3" type="submit" value="참여하기" style="background-color: var(--indigo);">
		</div>
	
	</div>
			
	<!-- Modal -->
		<div class="modal fade center" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title">다른 결제수단</h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body">
					<div >
					 
					<label class="ficnic_pay_ficnicPay" >
					<input class="ficnic_pay_modal mr-2" type="radio" name="reserv_payment2" id="modalradio2" data-bs-dismiss="modal" value="naverpay">네이버 페이
					</label>
					</div>
					<div >	  
					  <label class="ficnic_pay_ficnicPay" >
					    <input class="ficnic_pay_modal mr-2" type="radio" name="reserv_payment2"  data-bs-dismiss="modal" value="kakaopay">카카오페이
					  </label>
					</div>
					<div >
					 
					  <label class="ficnic_pay_ficnicPay">
					     <input class="ficnic_pay_modal mr-2" type="radio" name="reserv_payment2"  data-bs-dismiss="modal" value="sampay">삼성페이
					  </label>
					</div>
					<div >
					 
					  <label class="ficnic_pay_ficnicPay">
					     <input class="ficnic_pay_modal mr-2" type="radio" name="reserv_payment2"  data-bs-dismiss="modal" value="toss">토스
					  </label>
					</div>
					<div >
					  
					  <label class="ficnic_pay_ficnicPay">
					    <input class="ficnic_pay_modal mr-2" type="radio"  name="reserv_payment2" data-bs-dismiss="modal" value="bank">무통장입금
					  </label>
					</div>
		      </div>
		      
		    </div>
		   
		  </div>
		</div>


</form>

</div>


<%@ include file="../layout/layout_footer.jsp" %>