package com.model2.mvc.service.purchase.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.purchase.PurchaseDao;

@Repository("purchaseDaoImpl")
public class PurchaseDaoImpl implements PurchaseDao {

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;


	public void setSqlsession(SqlSession sqlsession) {
		this.sqlSession = sqlsession;
	}

	public PurchaseDaoImpl() {
		System.out.println(this.getClass());
	}
//////////////////////////////////////////////////////////


	public void addPurchase(Purchase purchase) throws Exception{
		sqlSession.insert("PurchaseMapper.addPurchase", purchase);
	}

	// SELECT ONE
	public Purchase getPurchase(int tranNo) throws Exception{
		return sqlSession.selectOne("PurchaseMapper.getPurchase", tranNo);
	}

	// SELECT LIST
	public List<Purchase> getPurchaseList(Search search, String buyerId) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("buyerId", buyerId);
		return sqlSession.selectList("PurchaseMapper.getPurchaseList", map);
	}

	// SELECT SALES LIST
	public List<Purchase> getSalesList(Search search) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		return sqlSession.selectList("PurchaseMapper.getSalesList", map);
	}

	// UPDATE
	public void updatePurchase(Purchase purchase) throws Exception{
		sqlSession.update("PurchaseMapper.updatePurchase", purchase);
	}

	public void updateTranCode(Purchase purchase) throws Exception{
		sqlSession.update("PurchaseMapper.updateTranCode", purchase);
	}

	
	public int getTotalSalesCount(Search search) throws Exception{
		return sqlSession.selectOne("PurchaseMapper.getTotalSalesCount", search);
	}
	
	public int getTotalPurchaseCount(Search search, String buyerId) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("buyerId", new String(buyerId));
		return sqlSession.selectOne("PurchaseMapper.getTotalPurchaseCount", map);
	}
}