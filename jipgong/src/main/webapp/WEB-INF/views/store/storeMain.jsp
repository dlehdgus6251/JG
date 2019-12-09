<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!-- jstl core 쓸때 태그에 c 로 표시. -->
	<%@ include file="../includes/header.jsp"%>
	<%@ include file="../includes/nav.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="card-body">
			<div class="table-responsive">
				<table class="table table-bordered" id="dataTable" width="100%"
					cellspacing="0">
					<thead>
						<tr>
							
							<th>원본이미지</th>
							<th>썸네일</th>
							<th>제품번호</th>
							<th>제품명</th>
							<th>카테고리</th>
							<th>가격</th>
							<th>재고수량</th>
							<th>등록날짜</th>

						</tr>
					</thead>

					<tbody>
						<c:forEach var="store" items="${StoreList }">
							<tr>
								<td><img src="${store.img }"></td>
								
								<td><c:out value="${store.proNo }" /></td>
								<td><a href="${store.proNo }" class="move">
								<c:out value="${store.proName }" /></a></td>
								<td>${store.cateCode }</td>
								<td>
								<fmt:formatNumber value="${store.price }" pattern="###,###,###"/>
								</td>
								
								
								<!-- <td>$320,800</td> -->
							</tr>
						</c:forEach>
					</tbody>
				</table>
			
				<form id="actionForm" action="/store/storeMain" method="get">
					<input type="hidden" name="pageNum"
						value="${pageMaker.cri.pageNum }"> <input type="hidden"
						name="amount" value="${pageMaker.cri.amount }">
				</form>
				<!-- Modal 추가 -->
				<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
					aria-labelledby="myModalLabel" aria-hidden="true">
					<div class="modal-dialog" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="exampleModalLabel">Ready to
									Leave?</h5>
								<button class="close" type="button" data-dismiss="modal"
									aria-label="Close">
									<span aria-hidden="true">×</span>
								</button>
							</div>
							<div class="modal-body">Select "Logout" below if you are
								ready to end your current session.</div>
							<div class="modal-footer">
								<button class="btn btn-secondary" type="button"
									datadismiss="modal">Cancel</button>
								<a class="btn btn-primary" href="login.html">Logout</a>
							</div>
						</div>
					</div>
				</div>
				<div>
				<div class="col-lg-12">
					<form id="searchForm" action="/store/storeMain" method="get">
						&nbsp;&nbsp;&nbsp;<select name="type">
							<option value="" ${pageMaker.cri.type==null?"selected":"" }>
								--</option>
							<option value="T" ${pageMaker.cri.type eq "T"?"selected":"" }>
								제품명</option>
							<option value="C" ${pageMaker.cri.type eq "C"?"selected":"" }>
								인기순</option>
							<option value="W" ${pageMaker.cri.type eq "W"?"selected":"" }>
								신상품순</option>
							<option value="TC" ${pageMaker.cri.type eq "TC"?"selected":"" }>
								제목+내용</option>
							<option value="TW" ${pageMaker.cri.type eq "TW"?"selected":"" }>
								제목+작성자</option>
							<option value="WC" ${pageMaker.cri.type eq "WC"?"selected":"" }>
								내용+작성자</option>
							<option value="TWC" ${pageMaker.cri.type eq "TWC"?"selected":"" }>
								제목+내용+작성자</option>
						</select> <input type="text" name="keyword" /> <input type="hidden"
							name="pageNum" value="${pageMaker.cri.pageNum }"> <input
							type="hidden" name="amount" value="${pageMaker.cri.amount }">
						<button class="btn btn-warning">Search</button>
					</form>
				</div>
			</div>
			<div>
				<ul class="pagination justify-content-center">
					<c:if test="${pageMaker.prev }">
						<li class="page-item previous"><a
							href="${pageMaker.startPage-1 }" class="page-link">prev</a></li>
					</c:if>

					<c:forEach var="num" begin="${pageMaker.startPage }"
						end="${pageMaker.endPage }">
						<li class='page-item ${pageMaker.cri.pageNum==num?"active":"" }'>
							<a href="${num }" class="page-link"> ${num }</a>
						</li>
					</c:forEach>

					<c:if test="${pageMaker.next }">
						<li class="page-item next"><a href="${pageMaker.endPage+1 }"
							class="page-link">next</a></li>
					</c:if>

				</ul>
			</div>	


			<form id="actionForm" action="/store/storeMain" method="get">
				<input type="hidden" name="pageNum"
					value="${pageMaker.cri.pageNum }"> <input type="hidden"
					name="amount" value="${pageMaker.cri.amount }">
					 <input	type="hidden" name="type" value="${pageMaker.cri.type }"> 
					 <input type="hidden" name="keyword" value="${pageMaker.cri.keyword }">
			</form>
				<script>
					// 컨트롤러에서 데이터 받기
					var jsonData = JSON.parse('${category}');
					console.log(jsonData);

					var cate1Arr = new Array();
					var cate1Obj = new Object();

					// 1차 분류 셀렉트 박스에 삽입할 데이터 준비
					for (var i = 0; i < jsonData.length; i++) {

						if (jsonData[i].level == "1") {
							cate1Obj = new Object(); //초기화
							cate1Obj.cateCode = jsonData[i].cateCode;
							cate1Obj.cateName = jsonData[i].cateName;
							cate1Arr.push(cate1Obj);
						}
					}

					// 1차 분류 셀렉트 박스에 데이터 삽입
					var cate1Select = $("select.category1")

					for (var i = 0; i < cate1Arr.length; i++) {
						cate1Select
								.append("<option value='" + cate1Arr[i].cateCode + "'>"
										+ cate1Arr[i].cateName + "</option>");
					}
				</script>
<script type="text/javascript">
$(document).ready(function() {
	var result = '<c:out value="${result}"/>';
	console.log("history.state : "+ history.state);
	console.log("result : " + result);
	checkModal(result);
	history.replaceState({}, null, null);
	// 스택구조에 누적된 히스토리 객체를 지워라
	// 3개의 인자는 state객체, 제목, url
	function checkModal(result) {
		if (result === ''|| history.state != null) {
			/* 결과가 없거나 히스토리가 있다면 */
			// 값과 타입도 검사. 형태도 맞고 값도 맞는다면
			// 넘겨 받은 값이 있다면,
			// 스택구조로 쌓인 정보가 있다면
			return;
			}
		if (parseInt(result) > 0) {
			$(".modal-body").html("게시글 "+ parseInt(result)	+ "번이 등록");
			}
		 $("#myModal").modal("show"); 
		}

	var actionForm = $("#actionForm"); 
	// 클래스 page-item 에 a 링크가 클릭 된다면,
	$(".page-item a").on("click",function(e) {
		e.preventDefault();
		// 기본 이벤트 동작을 막고,
		
		console.log("click");
		// 웹 브라우저 검사 창에 클릭을 표시		
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		// 액션폼 인풋태그에 페이지넘 값을 찾아서,
		// href로 받은 값으로 대체함.
		actionForm.submit();
		});
	$(".move").on("click", function(e) {
		e.preventDefault();
		actionForm.append("<input type='hidden' name='proNo' " + "value='"+ $(this).attr("href") + "'>");
		actionForm.attr("action", "/store/storeDetail");
		actionForm.submit();
		});
	});
</script>
<script>
$(document).ready(function() {
	$('#dataTable').DataTable({
		"order" : [ [ 0, "desc" ] ], //정렬 0컬럼의 내림차순으로
		"paging" : false, // 페이징 표시 안함.
		"bFilter" : false, // 검색창 표시 안함.
		"info" : false
		// 안내창 표시 안함.
		})
	})
</script>
</body>
</html>