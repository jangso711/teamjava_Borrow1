package org.kosta.borrow.controller;

public class HandlerMapping {
	private static HandlerMapping instance= new HandlerMapping();
	private HandlerMapping() {}
	public static HandlerMapping getInstance() {
		return instance;
	}
	public Controller create(String command) {
		Controller controller = null;
		if(command.equals("Main")) {
			controller = new MainController();
		}else if(command.equals("Login")) {
			controller = new LoginController();
		}else if(command.equals("LoginForm")) {
			controller = new LoginFormController();
		}else if(command.equals("Logout")) {
			controller = new LogoutController();
		}else if(command.equals("MemberRegisterForm")) {
			controller = new MemberRegisterFormController();
		}else if(command.equals("MemberRegister")) {
			controller = new MemberRegisterController();
		}else if(command.equals("MemberUpdateForm")) {
			controller = new MemberUpdateFormController();
		}else if(command.equals("MemberUpdate")) {
			controller = new MemberUpdateController();
		}else if(command.equals("MemberDetail")) {
			controller = new MemberDetailController();
		}else if(command.equals("MemberMypage")) {
			controller = new MemberMypageController();
		}else if(command.equals("MemberIdCheck")) {
			controller = new MemberIdCheckController();
		}else if(command.equals("ItemSearch")) {
			controller = new ItemSearchController();
		//180903 MIRI ItemCategorySearchController 추가
		}else if(command.equals("ItemCategorySearch")) {
			controller = new ItemCategorySearchController();
		}else if(command.equals("ItemAllSearch")) {
			controller = new ItemAllSearchController();
		}else if(command.equals("ItemDetail")) {
			controller = new ItemDetailController();
		}else if(command.equals("ItemRegisterForm")) {
			controller = new ItemRegisterFormController();
		}else if(command.equals("ItemRegister")) {
			controller = new ItemRegisterController();
		}else if(command.equals("PictureUpload")) {
			controller=new PictureUploadController();
		}else if(command.equals("DeleteServerPicture")) {
			controller=new DeleteServerPictureController();
		}else if(command.equals("ItemUpdateForm")) {
			controller = new ItemUpdateFormController();
		}else if(command.equals("ItemUpdate")) {
			controller = new ItemUpdateController();
		}else if(command.equals("ItemDelete")) {
			controller = new ItemDeleteController();
		}else if(command.equals("ItemDeleteResult")) {
			controller = new ItemDeleteResultController();	//180904 SOJEONG 추가
		}else if(command.equals("ItemRentDetail")) {
			controller = new ItemRentDetailController();
		}else if(command.equals("ItemRentalList")) {
			controller = new ItemRentalListController();
		//180901 MIRI ItemRentalController 추가
		}else if(command.equals("ItemRental")) {
			controller = new ItemRentalController();
		}else if(command.equals("ItemRegisterList")) {
			controller = new ItemRegisterListController();
		}else if(command.equals("ItemRegisterAllList")){
			controller= new ItemRegisterAllListController();
		}else if(command.equals("ItemDeleteCheck")) {
			controller = new ItemDeleteCheckController();
		}else if(command.equals("FAQ")) {
			controller=new FAQController();
		}else if(command.equals("MemberDepositPoint")) {
			controller=new MemberDepositPointController();
		}else if(command.equals("MemberDepositPointForm")) {
			controller=new MemberDepositPointFormController();
		}else if(command.equals("MemberWithdrawPoint")) {
			controller=new MemberWithdrawPointController();
		}else if(command.equals("MemberWithdrawPointForm")) {
			controller=new MemberWithdrawPointFormController();
			//180904 동규 MemberFindPwdController 추가
		}else if(command.equals("MemberFindPwd")) {
			controller=new MemberFindPwdController();
		}else if(command.equals("MemberFindPwdForm")) {
			controller=new MemberFindPwdFormController();
		}else if(command.equals("rentalCancel")) {
			controller = new rentalCancelController();			
		}else if(command.equals("ItemEarlyReturn")) {
			controller=new ItemEarlyReturnController();
		}else if(command.equals("ReviewList")) {
			controller=new ReviewListController();
		}else if(command.equals("ReviewPost")) {
			controller=new ReviewPostController();
		}else if(command.equals("ReviewRegisterForm")) {
			controller=new ReviewRegisterFormController();	//180905 SOJEONG 추가
		}else if(command.equals("ReviewRegister")) {
			controller=new ReviewRegisterController();	//180905 SOJEONG 추가
		}
		return controller;
	}
}
