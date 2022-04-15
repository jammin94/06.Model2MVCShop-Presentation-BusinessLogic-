package com.model2.mvc.web.purchase;

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
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.user.UserService;


//==> 회원관리 Controller
@Controller
public class PurchaseController {
	
	///Field
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
		
	public PurchaseController(){
		System.out.println(this.getClass());
	}
	
	//==> classpath:config/common.properties  ,  classpath:config/commonservice.xml 참조 할것
	//==> 아래의 두개를 주석을 풀어 의미를 확인 할것
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	
	@RequestMapping("/addPurchaseView.do")
	public ModelAndView addPurchaseView ( @RequestParam("prodNo") int prodNo) throws Exception {

		System.out.println("/addPurchaseView.do");
		System.out.println(prodNo);
		//Business Logic
		
		Product product= productService.getProduct(prodNo);
		System.out.println(product);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("product",product);
		modelAndView.setViewName("/purchase/addPurchaseView.jsp");

		return modelAndView;
	}
	
	@RequestMapping("/addPurchase.do")
	public ModelAndView addPurchase( @ModelAttribute("purchase") Purchase purchase,
			HttpSession session,  @RequestParam("prodNo") int prodNo ) throws Exception {

		System.out.println("/addPurchase.do");
		
		//Business Logic
		purchase.setBuyer((User)session.getAttribute("user"));
		purchase.setPurchaseProd(productService.getProduct(prodNo));
		purchaseService.addPurchase(purchase);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/purchase/addPurchaseDone.jsp");
		
		return modelAndView;
	}
	
	
	@RequestMapping("/getPurchase.do")
	public ModelAndView getPurchase( @ModelAttribute("purchase") Purchase purchase ) throws Exception {

		System.out.println("/getPurchase.do");
		//Business Logic
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("purchase", purchaseService.getPurchase(purchase.getTranNo()));
		modelAndView.setViewName("/purchase/getPurchase.jsp");
		
		return modelAndView;
	}
	
	
	@RequestMapping("/listPurchase.do")
	public ModelAndView listPurchase( @ModelAttribute("purchase") Purchase purchase, 
			@ModelAttribute("search") Search search, HttpSession session ) throws Exception {

		System.out.println("/listPurchase.do");
		//Business Logic
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		User sessionUser=(User)session.getAttribute("user");
		System.out.println(search);
		
		// Business logic 수행
		
		Map<String , Object> map= null;
			
		if(sessionUser.getRole()=="admin") {
			map=purchaseService.getPurchaseList(search,sessionUser.getUserId());
		}else {
			map=purchaseService.getSalesList(search);
		}
				
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		// Model 과 View 연결		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);
		
		if(sessionUser.getRole()=="admin") {
			modelAndView.addObject("menu", "search");
		}else {
			modelAndView.addObject("menu", "manage");
		}
		
		
		modelAndView.setViewName("/purchase/listPurchase.jsp");
		
		return modelAndView;
	}
	
	@RequestMapping("/updatePurchaseView.do")
	public ModelAndView updatePurchaseView( @ModelAttribute("purchase") Purchase purchase ) throws Exception {
		
		System.out.println("/updatePurchaseView.do");
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("purchase",purchaseService.getPurchase(purchase.getTranNo()));
		
		modelAndView.setViewName("/purchase/updatePurchaseView.jsp");
		
		return modelAndView;
	
	}
	
	@RequestMapping("/updatePurchase.do")
	public ModelAndView updatePurchase( @ModelAttribute("purchase") Purchase purchase ) throws Exception {
		
		System.out.println("/updatePurchase.do");
		
		purchaseService.updatePurchase(purchase);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("redirect:/getPurchase.do?tranNo="+purchase.getTranNo());
		
		return modelAndView;
	
	}
	
	@RequestMapping("/updateTranCode.do")
	public ModelAndView updateTranCode( @ModelAttribute("purchase") Purchase purchase) throws Exception {	

		System.out.println("/updateTranCode.do");
		
		purchaseService.updateTrancode(purchase);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("redirect:/listPurchase.do");
		
		return modelAndView;
	
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}