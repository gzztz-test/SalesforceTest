public with sharing class PageUtilities {
	Integer eachCount{set;get;}
	Integer totalCount{set;get;}
	Integer pageCount{set;get;}
	Integer isPlus;
	String recordName;
	Integer N;
	Integer currentPage;
	List<Account> showList{set;get;}
	Integer offNum;



	//public PageUtilities() {
	//}
	//public PageUtilities(String dataName,String eachCount){
	//	N = 0;
	//	recordName = dataName;
	//	currentPage = 1;
	//    offNum = 0;
	//	showList = new List<Account>;
	//	List<recordName> recordList = new List<recordName>();
	//	for(recordName r : [SELECT Id,Name FROM :recordName]){
	//		recordList.add(r);

	//	}
	//	totalCount = recordList.size();
	//	this.eachCount = eachCount;
	//	isPlus = totalCount%eachCount;
	//	pageCount = totalCount/eachCount;
	//	if(isPlus!=0){
	//		pageCount++;
	//	}
	//	for(int i=0;i<eachCount;i++){
	//		showList.add(recordList[i]);
	//	}
	//}

	//public void nextPage(){
	//	offNum+=5;
	//	showList.clear();
	//	for(Account a = [SELECT Name,Id FROM :recordName LIMIT 5 OFFSET :offNum ]){
	//		showList.add(a);
	//	}
	//}
	//public void previousPage(){
	//	offNum=offNum-5;
	//		showList.clear();
	//	for(Account a = [SELECT Name,Id FROM :recordName LIMIT 5 OFFSET :offNum ]){
	//		showList.add(a);

	//}
	//public void firstPage(){
	//	offNum = 0;
	//	showList.clear();
	//	for(Account a = [SELECT Name,Id FROM :recordName LIMIT 5 OFFSET :offNum ]){
	//		showList.add(a);
	//}
	//public void lastPage(){

	//}


}