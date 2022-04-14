package com.model2.mvc.service.purchase;

import java.util.List;
import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Purchase;

public interface PurchaseDao {
	public void addPurchase(Purchase purchase) throws Exception ;

	// SELECT ONE
	public Purchase getPurchase(int tranNo) throws Exception ;

	// SELECT LIST
	public List<Purchase> getPurchaseList(Search search, String buyerId) throws Exception ;

	// SELECT SALES LIST
	public List<Purchase> getSalesList(Search search) throws Exception ;

	// UPDATE
	public void updatePurchase(Purchase purchase) throws Exception ;


	public void updateTranCode(Purchase purchase) throws Exception ;

	
	public int getTotalSalesCount(Search search) throws Exception ;
	
	
	public int getTotalPurchaseCount(Search search, String buyerId) throws Exception ;
	


}