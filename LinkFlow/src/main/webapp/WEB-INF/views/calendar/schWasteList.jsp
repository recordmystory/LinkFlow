<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>schWasteList</title>
<!-- 지도 api -->
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=dffz3x1msk&submodules=geocoder"></script>

<style>
    .wrapper{
      min-height: 100%;
      width: 100%;
   }
  .LinkFlowMainSection{
      width: 100%;
      min-height: 1500px;
      display: flex;
    
  }
  .LinkFlowMainContent{
      width: 100%;
      min-width: 1260px;
      background-color: #f4f6f9;
      min-height: 400px;
      padding: 30px;
  }
  .contentInElement{display: flex; justify-content: space-between; margin-bottom: 30px;}
  .contentArea{ 
   width: 100%;
  }
  
  .dmovePage .slimMenu {
     padding: .0rem 0rem;
   }

 /*여기까지 메인 영역 요소  공용 스타일임 */
		.bin_list_table td, .bin_list_table th{
      text-align: center;
      font-size: small;

    }
     .dataTables_filter {
      float: right;
      margin-bottom: 5px;
    }

    /*휴지통 상세 정보 모달 스타일*/
    .schDetailModal_content, .modal-content{
      display: flex;
      justify-content: center;
      text-align: center;
      margin: 0px 0px 20px 10px;
    }

    .modal-title{
      margin-left: 20px;
      display: flex;
      text-align: center;
      justify-content: center;
    }

    .schDetailModal_content > p, .search {
      margin:auto;
   }

    #schDetailModal_content_text{
      max-width: 300px;
    
    }

    #detailBtn-modal-body{
      font-size: large;
      font-weight: bolder;
      display: flex;
      justify-content: center;
      align-items: center;
      text-align: center;
      height: 350px;
    }


</style>
</head>
<body>
<div class="wrapper">
	
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	
	<div class="LinkFlowMainSection">
	            
	   <jsp:include page="/WEB-INF/views/common/sidebar/calendar/calendarSidebar.jsp"/>
	   
            
            <!-- 휴지통 header start -->
            <div class="LinkFlowMainContent">
              <!-- Content Header (Page header) -->
              <section class="content-header">
                <p style="text-align: end;">삭제 일정은  <spen style="color: red;">30</spen>일 후  영구  삭제됩니다.</p>
                <div class="row mb-2">
                  <div class="col-sm-6">
                      <h1 class="m-0 mx-4">휴지통</h1>
                  </div>
                </div>
              <!-- /.container-fluid -->
              </section>
               
              <!-- 휴지통 Main content start -->
              
              <section class="content">
                <div class="container-fluid"> 
                  <div class="contentArea">
                    <div class="form-group mx-4">
                      <select class="custom-select col-sm-2 text-sm">
                        <option selected hidden>모든 캘린더</option>
                        <option>개인 캘린더</option>
                        <option>부서 캘린더</option>
                        <option>전사캘린더</option>
                      </select>
                    </div>
                      
                   <!-- /.card-header -->
                    <div class="card-body">
                      <table id="example1" class="table table-bordered table-striped bin_list_table">
                        <thead>
                        <tr>
                          <th>No.</th>
                          <th>일정명</th>
                          <th>삭제일</th>
                          <th>캘린더 종류</th>
                          <th>복구/삭제</th>
                        </tr>
                        </thead>
                        <tbody>
                          <tr>
                            <td>1</td>
                            <td><a href="#" class="open-modal" data-bs-toggle="modal" data-bs-target="#schDetailModal">점심 약속</a></td>
                            <td>2024/04/11</td>
                            <td>개인 캘린더</td>
                            <td>
                              <button type="button" class="btn btn-primary btn-sm">복구</button>
                              <button type="button" class="btn btn-secondary btn-sm" >삭제</button> </td>
                          </tr>
                          <tr>
                            <td>2</td>
                            <td><a href="#" class="open-modal" data-bs-toggle="modal" data-bs-target="#schDetailModal">생일</a></td>
                            <td>2024/04/21</td>
                            <td>
                              공유 캘린더<br>
                              <span style="font-size: 11px; white-space:nowrap;">홍지우 팀장&lt;개발1팀&gt;</span>
                            </td>
                            <td>
                              <button type="button" class="btn btn-primary btn-sm">복구</button>
                              <button type="button" class="btn btn-secondary btn-sm" >삭제</button></td>
                          </tr>
                          <tr>
                            <td>3</td>
                            <td><a href="#" class="open-modal" data-bs-toggle="modal" data-bs-target="#schDetailModal">개발2팀 회식</a></td>
                            <td>2024/04/23</td>
                            <td>
                              부서 캘린더
                            </td>
                            <td>
                              <button type="button" class="btn btn-primary btn-sm">복구</button>
                              <button type="button" class="btn btn-secondary btn-sm" >삭제</button>
                            </td>
                          </tr>
                        </tbody>
                      </table>
                    </div>
                    <!-- /.card-body -->
                  </div>
                  <!-- /.card -->
                </div>
                <!-- /.col -->
              </div>
              <!-- /.row -->
            </div>
            <!-- /.container-fluid -->
          </section>
          <!-- /.content -->
        </div>
      <!-- /.content-wrapper -->

          <!-- 일정 상세 정보 모달 start -->
        <div class="modal fade" id="schDetailModal" tabindex="-1" aria-labelledby="schDetailModal" aria-hidden="true">
          <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
              <div class="modal-content">
                  <div class="modal-header justify-content-center">
                      <h5 class="modal-title font-weight-bolder" id="schDetailTitle">개발2팀 회식</h5>
                  </div>
                  <div class="modal-body">
                      <div>
                          <div class="schDetailModal_content justify-content-end mx-1">
                            중요일정&nbsp;
                            <input type="checkbox" class="weste-modal" id="recipient-name">
                          </div>
                          <div class="schDetailModal_content font-weight-bolder">
                              <label for="recipient-name" class="col-form-label">캘린더</label>
                              <p style="padding-right: 30px;">부서 캘린더</p> 
                          </div>
                          <div class="schDetailModal_content"> 
                            <label for="recipient-name" class="col-form-label">일정</label> 
                            <p>2024/04/26&nbsp; 오전 9:30 ~ 오전 10:00</p> 
                          </div>
                          <!--조건 걸어야함-->
                          <div class="schDetailModal_content">
                            <label for="recipient-name" class="col-form-label">장소</label>
                            <div class="search">
                              <div>서울시 서초구 방배동 939-949</div>
                              <div id="map" style="width:300px; height:200px; margin-top:30px;"></div>
                            </div>                          
                          </div>
                          <!---->
                          <div class="schDetailModal_content">
                            <label for="recipient-name" class="col-form-label">알림</label>
                            <p>
                              30분 전 메일발송
                              <input type="checkbox" class="weste-modal" id="recipient-name">
                            </p>
                          </div>
                          <div class="schDetailModal_content">
                            <label for="message-text" class="col-form-label">내용</label>
                            <p id="schDetailModal_content_text"> 
                                 서울시 서초구 방배동 939-949에 있는
                                '떡봉솥뚜껑닭볶음탕찾아주셔서서감사
                                 합니다' 에서 부서 전체 회식
                            </p>
                          </div>
                       </div>
                  </div>
                  <div class="modal-footer justify-content-center">
                      <button type="button" class="btn blue-button" data-bs-target="#detailBtn" data-bs-toggle="modal" style="color: white;">복구</button>
                      <button type="button" class="btn gray-button" data-bs-target="#detailBtn" data-bs-toggle="modal" style="color: white;">삭제</button>
                  </div>
              </div>
            </div>
        </div>
        <!--일정 상세 정보 모달 end-->
        <!--상세 정보 모달_버튼 모달 start-->
        <div class="modal fade" id="detailBtn" aria-hidden="true" aria-labelledby="detailBtnLabel" tabindex="-1">
          <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
              <div class="modal-body" id="detailBtn-modal-body" > 
              </div>
              <div class="modal-checkBtn">
                <i class="fa-solid fa-check fa-xl mb-5 mr-4" style="color: #055dd1;"></i>
                <i class="fa-solid fa-xmark fa-xl mb-5 before-btn" style="color: #bcbdbd;"></i>
              </div>
            </div>
          </div>
        </div>
        <!--상세 정보 모달_버튼 모달 ends-->

        
		<!-- DataTables  & Plugins -->
    <script src="${contextPath}/resources/htmlTemplate/plugins/datatables/jquery.dataTables.min.js"></script>
    <script src="${contextPath}/resources/htmlTemplate/plugins/datatables-bs4/js/dataTables.bootstrap4.min.js"></script>
    <script src="${contextPath}/resources/htmlTemplate/plugins/datatables-responsive/js/dataTables.responsive.min.js"></script>
    <script src="${contextPath}/resources/htmlTemplate/plugins/datatables-responsive/js/responsive.bootstrap4.min.js"></script>
    <script src="${contextPath}/resources/htmlTemplate/plugins/datatables-buttons/js/dataTables.buttons.min.js"></script>
    <script src="${contextPath}/resources/htmlTemplate/plugins/datatables-buttons/js/buttons.bootstrap4.min.js"></script>
    
<script>
//페이징 기능
		$(function () {
		    $("#example1").DataTable({
		      "responsive": true, "lengthChange": false, "autoWidth": false,
		    });
		  });


    // schDetailModal : 휴지통 스케쥴 상세 모달
      $(document).ready(function() {
        $('.open-modal').click(function(){
            $('#schDetailModal').modal('show');
            
        });

        $('#schDetailModal').on('show.bs.modal', function(e) {
            $('body').addClass('modal-open'); // 바디에 modal-open 클래스 추가
            $('.modal-backdrop').addClass('show'); // 모달 백드롭에 show 클래스 추가
        });

        // schDetailModal이 닫힐 때
        $('#schDetailModal').on('hidden.bs.modal', function(e) {
            $('body').removeClass('modal-open'); // 바디에서 modal-open 클래스 제거
            $('.modal-backdrop').removeClass('show'); // 모달 백드롭에서 show 클래스 제거
        });

      // schDetailModals에서 detailBtn 클릭시
        $('.blue-button').click(function() {
          $('#schDetailModal').modal('hide'); 
          $('#detailBtn-modal-body').html('<div>일정을 복구하시겠습니까?</div>');
            $('#detailBtn').modal('show');
            $('body').addClass('overflow-hidden');   
        });

        $('.gray-button').click(function() {
          $('#schDetailModal').modal('hide'); 
          $('#detailBtn-modal-body').html('<div>일정을 삭제하시겠습니까?<p style="color:red; font-size:small; padding-top:10px;">삭제된 일정은 복구할 수 없습니다.</p></div>');
            $('#detailBtn').modal('show');
            $('body').addClass('overflow-hidden');
        });

        $('#detailBtn').on('hidden.bs.modal', function() {
            $('body').removeClass('overflow-hidden');
        });
    });

//네이버 지도 api start
    selectMapList();

//검색한 주소의 정보를 insertAddress 함수로 넘겨준다
      function searchAddressToCoordinate(address) {
        naver.maps.Service.geocode({
            query: address
        }, function(status, response) {
            if (status === naver.maps.Service.Status.ERROR) {
                return alert('Something Wrong!');
            }
            if (response.v2.meta.totalCount === 0) {
                return alert('올바른 주소를 입력해주세요.');
            }
            var htmlAddresses = [],
                item = response.v2.addresses[0],
                point = new naver.maps.Point(item.x, item.y);
            if (item.roadAddress) {
                htmlAddresses.push('[도로명 주소] ' + item.roadAddress);
            }
            if (item.jibunAddress) {
                htmlAddresses.push('[지번 주소] ' + item.jibunAddress);
            }
            if (item.englishAddress) {
                htmlAddresses.push('[영문명 주소] ' + item.englishAddress);
            }

            insertAddress(item.roadAddress, item.x, item.y);
            
        });
      }

  //주소 검색의 이벤트
      $('#address').on('keydown', function(e) {
          var keyCode = e.which;
          if (keyCode === 13) { // Enter Key
              searchAddressToCoordinate($('#address').val());
          }
      });
      $('#submit').on('click', function(e) {
          e.preventDefault();
          searchAddressToCoordinate($('#address').val());
      });
      naver.maps.Event.once(map, 'init_stylemap', initGeocoder);


  //지도에 마커 찍기
      function insertAddress(latitude, longitude) {
        var map = new naver.maps.Map('map', {
            center: new naver.maps.LatLng(longitude, latitude),
            zoom: 50,
            scaleControl: false,
            logoControl: false,
            mapDataControl: false,
            zoomControl: false,
            zoomControlOptions: {
              style: naver.maps.ZoomControlStyle.SMALL,
              position: naver.maps.Position.TOP_LEFT
            },
            mapTypeControl: false
        });
          var marker = new naver.maps.Marker({
              map: map,
              position: new naver.maps.LatLng(longitude, latitude),
          });
      }
  //지도를 그려주는 함수
      function selectMapList() {
        
        var map = new naver.maps.Map('map', {
            center: new naver.maps.LatLng(37.3595704, 127.105399),
            zoom: 10
        });
      }


  // 지도를 이동하게 해주는 함수
      function moveMap(len, lat) {
        var mapOptions = {
              center: new naver.maps.LatLng(len, lat),
              zoom: 15
          };
          var map = new naver.maps.Map('map', mapOptions);
          var marker = new naver.maps.Marker({
              position: new naver.maps.LatLng(len, lat),
              map: map
          });
      }
//네이버 지도 api end
</script>
</body>
</html>

</body>
</html>