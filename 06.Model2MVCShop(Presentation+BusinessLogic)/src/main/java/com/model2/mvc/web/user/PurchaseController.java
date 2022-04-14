package com.model2.mvc.web.user;

import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.purchase.PurchaseService;


//==> ȸ������ Controller
@Controller
public class PurchaseController {
	
	///Field
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	//setter Method ���� ����
		
	public PurchaseController(){
		System.out.println(this.getClass());
	}
	
	//==> classpath:config/common.properties  ,  classpath:config/commonservice.xml ���� �Ұ�
	//==> �Ʒ��� �ΰ��� �ּ��� Ǯ�� �ǹ̸� Ȯ�� �Ұ�
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	
	@RequestMapping("/addPurchaseView.do")
	public String addPurchaseView( @ModelAttribute("product") Purchase purchase ) throws Exception {

		System.out.println("/addProduct.do");
		//Business Logic
		purchaseService.addProduct(product);
		int prodNo=purchaseService.getProductNo(product.getProdName());

		
		return "redirect:/getProduct.do?prodNo="+prodNo;
	}
	
	@RequestMapping("/addPurchase.do")
	public String addPurchase( @ModelAttribute("purchase") Purchase purchase ) throws Exception {

		System.out.println("/addProduct.do");
		//Business Logic
		purchaseService.addProduct(product);
		int prodNo=purchaseService.getProductNo(product.getProdName());

		
		return "redirect:/getProduct.do?prodNo="+prodNo;
	}
	
	
	@RequestMapping("/getProduct.do")
	public String getProduct(@RequestParam("prodNo") String prodNo,HttpServletRequest request,HttpServletResponse response, Model model ) throws Exception {
	
		System.out.println("/getProduct.do");
		//Business Logic
		Product product = purchaseService.getProduct(Integer.parseInt(prodNo));
		model.addAttribute(product);
		
		//Cookie �ذ�
		Cookie cookie = null;
		Cookie[] cookies = request.getCookies();
		
		if (cookies!=null && cookies.length > 0) {
			for (Cookie c : cookies) {
				if (c.getName().equals("history")) {
					cookie=new Cookie("history",c.getValue()+"!"+prodNo);
					System.out.println(cookie.getValue());
				}	
			}
			
			if(cookie==null) {
				cookie=new Cookie("history",prodNo);
			}
		}
		
		response.addCookie(cookie);
		
		return "product/getProduct.jsp";
		
	}
	
	@RequestMapping("/updateProductView.do")
	public String UpdateProductView( @RequestParam("prodNo") String prodNo, Model model ) throws Exception {

		System.out.println("/addProductView.do");
		//Business Logic
		Product product=purchaseService.getProduct(Integer.parseInt(prodNo));
		
		model.addAttribute(product);

		return "/product/updateProductView.jsp";
	}
	
	@RequestMapping("/updateProduct.do")
	public String UpdateProduct( @ModelAttribute("product") Product product ) throws Exception {

		System.out.println("/updateProduct.do");
		//Business Logic
		purchaseService.updateProduct(product);

		return "redirect:/getProduct.do?prodNo="+purchaseService.getProductNo(product.getProdName());
	}
	
	@RequestMapping("/listProduct.do")
	public String listProudct( @ModelAttribute("search") Search search , Model model) throws Exception{
		
		System.out.println("/listProduct.do");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic ����
		Map<String , Object> map=purchaseService.getProductList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model �� View ����
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		model.addAttribute("menu", "search");
		
		return "forward:/product/listProduct.jsp";
	}
	
}