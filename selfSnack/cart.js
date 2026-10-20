	document.addEventListener('DOMContentLoaded',function(){
		const minusBtn= document.getElementById("minusBtn");
		const plusBtn= document. getElementById("plusBtn");
		const quantityInput = document.getElementById("quantity");
		
		if(minusBtn){
			minusBtn.addEventListener('click',function(){
				let current = parseInt(quantityInput.value);
				if(current>1) {
					quantityInput.value =current -1;
										
				}
			});
		}
		
		if(plusBtn){
			plusBtn.addEventListener('click',function(){
				let current = parseInt(quantityInput.value);
				
				quantityInput.value =current+1;
				});
				
			}
		});
		



	function insertCart(serial,event){
		
		if(event){
			event.stopPropagation();
		}
		fetch('/myMiniProject/selfSnack/cartAddProduct.jsp?serial=' + serial)
			.then(response => response.text())
			.then(result => {
				let res = result.trim();
				console.log("서버응답값 : ["+res+"]");
			//숫자로 잘 변환된다면 (성공했다면)
			if(res !== "fail" && res !== "" && !isNaN(res)){
				let count = parseInt(res); //DB에 담긴 총수량
				if(count === 1){
					alert("장바구니에 상품을 담았습니다.");
				} else {
					alert("한번 더 담으셨네요. 담긴 수량이 " + count + "개가 되었습니다.")
				}
			}else {
				alert("장바구니에 담은 상품이 없습니다.");
			}
		})
			.catch(error =>{
				console.error('Error:', error);
				alert("오류가 발생했습니다.");});
			}
	
			


