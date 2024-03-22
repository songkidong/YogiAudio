<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<link href="/css/user/consent.css" rel="stylesheet">

</head>
<body>
	<%@include file="/WEB-INF/view/layout/header.jsp"%>

	<div class="container__custom">
		<div class="wrap__custom">
			<div class="logo__custom">
				<h2>약관동의</h2>
			</div>
			<div class="contents__custom">
				<form action="/signUp" method="GET" id="form__wrap"
					class="form__wrap__custom">
					<div class="terms__check__all__custom">
						<input type="checkbox" name="checkAll" id="checkAll" /> <label
							for="checkAll"> 모두 동의합니다.</label>
					</div>
					<ul class="terms__list__custom">
						<li class="terms__box__custom">
							<div class="input__check__custom">
								<input type="checkbox" name="agreement" id="termsOfService"
									value="termsOfService" required /> <label for="termsOfService"
									class="required__custom"> 서비스 이용약관 동의 (필수)</label>
							</div>
							<div class="terms__content__custom">서비스 이용약관 제1장 총칙 제1조
								[목적] 이 약관은 주식회사 요기오디오(이하 “회사”라 합니다)과 이용자 간에 “회사”가 제공하는 콘텐츠 서비스인
								YogiAudio 서비스(이하 “서비스”라 합니다) 및 제반 서비스를 유선 또는 무선 인터넷 등의 수단으로 이용함에
								있어 “회사”와 이용자 간의 권리, 의무에 관한 사항과 기타 필요한 사항을 규정하는 것을 목적으로 합니다. 제2조
								[용어의 정의] ① 이 약관에서 사용하는 용어의 정의는 다음 각 호와 같습니다. 1. “이용자”라 함은 “회사”가
								제공하는 “서비스”에 유선 또는 무선 인터넷 등의 수단으로 접속하여 이 약관에 따라 “회사”가 제공하는 “콘텐츠”
								및 제반 서비스를 이용하는 “회원” 및 “비회원”을 말합니다. 2. “회원”이라 함은 “회사”와 이용계약을 체결하고
								아이디(ID)를 부여 받은 “이용자”로서 “회사”의 정보를 지속적으로 제공받으며 “회사”가 제공하는 서비스를 이용할
								수 있는 자를 말합니다. 3. “비회원”이라 함은 “회원”이 아니면서 “회사”가 제공하는 서비스를 이용할 수 있는
								자를 말하며, “회사”는 “회원”과 “비회원”에게 제공하는 서비스에 차별을 두어 제공할 수 있습니다. 4.
								“아이디(ID)”라 함은 “회원” 식별과 “회원”의 서비스 이용을 위하여 “회원”이 선정하고 “회사”가 승인하는
								영문자와 숫자의 조합을 의미합니다. 5. “비밀번호(Password)”라 함은 “회원”이 부여 받은
								“아이디(ID)”와 일치되는 “회원”임을 확인하고 비밀보호를 위해 “회원”자신이 정한 문자 또는 숫자의 조합을
								말합니다. 6. “콘텐츠”라 함은 『정보통신망 이용촉진 및 정보 보호 등에 관한 법률』 제2조 제1항 제1호의
								규정에 의한 정보통신망에서 사용되는 부호, 문자, 음성, 음향, 이미지 또는 영상 등으로 표현된 자료 또는
								정보로서, 그 보존 및 이용에 있어서 효용을 높일 수 있도록 전자적 형태로 제작 또는 처리된 것을 말합니다. 7.
								“유료서비스”라 함은 “회원”이 일정 금액을 “결제”하고 이용할 수 있는 “콘텐츠” 서비스 또는 상품을 의미합니다.
								8. “지니캐시“라 함은 “회사”가 제공하는 다양한 “유료서비스”를 이용하기 위해 특정 결제수단 중 원하는
								지불수단을 선택하여 현금처럼 지불할 수 있는 사이버 머니를 말하며, 현금 1원당 “지니캐시“ 1원의 비율로
								충전됩니다. 9. “게시물”이라 함은 “서비스”에 “회원”이 올린 글, 그림, 사진, 음악선곡리스트, 각종 파일과
								링크, 각종 댓글 등의 정보의 총칭을 말합니다. 10. “상품권”이란 “회사”가 온∙오프라인에서 발행한
								“유료서비스” 이용권을 말하며, 사용방법은 “상품권” 또는 이용안내 페이지 등에 별도로 표기합니다. ② 본 조에서
								정의된 용어 이외의 용어에 대해서는 관계 법령 및 서비스별 안내에서 정의하는 바에 따릅니다. 제3조 [신원정보 등의
								제공] “회사”는 이 약관의 내용, 상호, 대표자 성명, 영업소 소재지 주소(소비자의 불만을 처리할 수 있는 곳의
								주소를 포함), 전화번호, 전자우편주소, 사업자등록번호, 통신판매업 신고번호 및 개인정보관리책임자 등을 이용자가
								쉽게 알 수 있도록 서비스 초기화면에 게시합니다. 다만, 약관 및 개인정보처리방침은 이용자가 연결화면을 통하여 볼
								수 있도록 할 수 있습니다.</div>
						</li>
						<li class="terms__box__custom">
							<div class="input__check__custom">
								<input type="checkbox" name="agreement" id="privacyPolicy"
									value="privacyPolicy" required /> <label for="privacyPolicy"
									class="required__custom"> 개인정보 수집/이용 동의 (필수)</label>
							</div>
							<div class="terms__content__custom">수집하는 개인정보의 항목 회사는 회원
								가입, 상담, 서비스 제공을 위하여 아래와 같이 최소한의 개인정보만을 수집하며, 사상·신념, 가족 및 친인척관계,
								학력(學歷)·병력(病歷), 기타 사회활동 경력 등 고객의 권리·이익이나 사생활을 뚜렷하게 침해할 우려가 있는
								개인정보를 수집하지 않습니다. 다만, 고객이 동의하거나 다른 법률에 따라 특별히 허용된 경우에는 필요한 범위에서
								최소한으로 위 개인정보를 수집할 수 있습니다. 회사는 고객의 개인정보를 필수정보와 선택정보로 구분하여 수집하고
								있습니다. 필수정보 제공에 동의하지 않는 경우 “요기오디오” 상품∙서비스 제공을 받기 어렵다는 점을 충분히
								설명해드리고 있으며, 선택정보 제공에 동의하지 않더라도 서비스 이용에는 제한이 없음을 알려드립니다.</div>
						</li>
						<li class="terms__box__custom">
							<div class="input__check__custom">
								<input type="checkbox" name="agreement" id="allowPromotions"
									value="allowPromotions" /> <label for="allowPromotions">마케팅
									활용 개인정보 수집/이용 동의</label>
							</div>
							<div class="terms__content__custom">마케팅 목적의 개인정보 수집/이용 동의
								개인정보보호법에 따라 개인정보 수집 및 이용 목적, 항목, 보유 및 이용기간, 동의 거부권 및 동의 거부 시 불이익
								사항을 안내 드리오니 확인하시어 동의하여 주시기 바랍니다. 1. 수집/이용 목적 인구통계학적 특성과 이용자의 관심,
								기호, 성향 분석을 통한 맞춤형 혜택 제공 및 마케팅 활용 2. 수집/이용 항목 · 서비스이용기록 · 상품구매이력
								· 사이트방문기록 · 연령대 · 성별 · 기기정보(OS종류, PUSH토큰, 디바이스ID) · 광고식별자 · 쿠키 ·
								브라우저 정보 · IP주소, MAC주소 · 휴대폰번호 3. 수집/이용 보유 및 이용기간 회원탈퇴 시까지 ※ 동의를
								거부할 수 있으나 동의하지 않을 시 맞춤형 상품 및 혜택을 받아보실 수 없습니다. ※ 광고식별자 수집 거부 방법
								안내 모바일 OS 버전에 따라 메뉴 및 방법이 다소 상이할 수 있습니다. - (안드로이드) 설정 → 개인정보보호 →
								광고 → 광고 ID 재설정 또는 광고 ID 삭제 - (아이폰) 설정 → 개인정보보호 → 추적 → 앱이 추적을
								요청하도록 허용 끔</div>
						</li>
						<li class="terms__box__custom">
							<div class="input__check__custom">
								<input type="checkbox" name="agreement" id="allowPromotions"
									value="allowPromotions" /> <label for="allowPromotions">광고성 정보 수신동의</label>
							</div>
							<div class="terms__content__custom">마케팅 목적의 개인정보 수집/이용 동의
								개인정보보호법에 따라 개인정보 수집 및 이용 목적, 항목, 보유 및 이용기간, 동의 거부권 및 동의 거부 시 불이익
								사항을 안내 드리오니 확인하시어 동의하여 주시기 바랍니다. 1. 수집/이용 목적 인구통계학적 특성과 이용자의 관심,
								기호, 성향 분석을 통한 맞춤형 혜택 제공 및 마케팅 활용 2. 수집/이용 항목 · 서비스이용기록 · 상품구매이력
								· 사이트방문기록 · 연령대 · 성별 · 기기정보(OS종류, PUSH토큰, 디바이스ID) · 광고식별자 · 쿠키 ·
								브라우저 정보 · IP주소, MAC주소 · 휴대폰번호 3. 수집/이용 보유 및 이용기간 회원탈퇴 시까지 ※ 동의를
								거부할 수 있으나 동의하지 않을 시 맞춤형 상품 및 혜택을 받아보실 수 없습니다. ※ 광고식별자 수집 거부 방법
								안내 모바일 OS 버전에 따라 메뉴 및 방법이 다소 상이할 수 있습니다. - (안드로이드) 설정 → 개인정보보호 →
								광고 → 광고 ID 재설정 또는 광고 ID 삭제 - (아이폰) 설정 → 개인정보보호 → 추적 → 앱이 추적을
								요청하도록 허용 끔</div>
						</li>
					</ul>
					<button id="signUp-button" type="submit"
						class="next-button__custom" disabled>회원가입</button>
				</form>
			</div>
		</div>
	</div>
	<script src="/js/user/consent.js"></script>
</body>

</html>
