
//update the cart
function updateCart(){
    let cartString = localStorage.getItem("cart");
    let cart = JSON.parse(cartString);
    if(cart === null || cart.length === 0){
       $(".cart-number").html("(0)");
       $(".cart-body").html("<h4>cart is empty</h4>");
       $(".checkout-btn").addClass("disabled");
    }
    else{
        console.log(cart);
        $(".cart-number").html(`(${cart.length})`);
        let table = `
            <table class='table'>
            <thead class='thread-light'>
                <tr>
                <th>Item Name </th>
                <th>Price </th>
                <th>Quantity</th>
                <th>Total Price</th>
                <th>Action</th>
                </tr>
            </thead>
            `;
        let totalPrice =0;
        cart.map((item)=>{
            table+=`
                        <tr>
                            <td>${item.productName}</td>
                            <td>${item.productPrice}</td>
                            <td>${item.productQuentity}</td>
                            <td>${item.productPrice*item.productQuentity}</td>
                            <td><button onclick='removeItemFromCart(${item.productId})' class="btn btn-danger btn-sm">Remove</button>
                                <button onclick='decreaseItemFromCart(${item.productId})' class="btn btn-danger btn-sm">-1</button>
                            </td>
                        </tr>
                    `
            totalPrice+=item.productQuentity*item.productPrice;
        });
        table=table+`
        <tr><td colspan='5' class='text-center' style='font-weight:bold'>Total Price: ${totalPrice}</td></tr> 
        </table>`;
        $(".cart-body").html(table);
        $(".checkout-btn").removeClass("disabled");
    }
}
//add items to cart
function addToCart(pId, pName, pPrice, pQuantity) {
    console.log("add");
    let cart = localStorage.getItem("cart");
    if (cart === null) {
        //no cart
        let products = [];
        let product = {productId : pId, productName : pName, productPrice : pPrice, productQuentity : 1};
        products.push(product);
        localStorage.setItem("cart", JSON.stringify(products));
        showToast(product.productName+" is added");
    } else {
        //cart has products  
        let newCart = JSON.parse(cart);
        let oldProduct = newCart.find((item) =>item.productId === pId);
      
        if(oldProduct && oldProduct.productQuentity<pQuantity){
            oldProduct.productQuentity=oldProduct.productQuentity+1;
            localStorage.setItem("cart",JSON.stringify(newCart));
            showToast(oldProduct.productName+" quantity increased, Quantity ="+oldProduct.productQuentity);
        }
        else if(oldProduct && oldProduct.productQuentity===pQuantity){
            showToast("max quantity recived");
        }
        else{
            let product = {productId : pId, productName : pName, productPrice : pPrice, productQuentity : 1};
            newCart.push(product);
            localStorage.setItem("cart",JSON.stringify(newCart));
            showToast(product.productName+" is added");
        }
        
    }
    console.log("add to cart");
    updateCart();
}

//Revome items from cart;
function removeItemFromCart(pId){
    let cart = JSON.parse(localStorage.getItem("cart"));
    let newCart = cart.filter((item)=>item.productId !== pId);
    localStorage.setItem('cart',JSON.stringify(newCart));
    showToast("Item is removed from the cart");
    updateCart();
}

$(document).ready(function(){
    updateCart();
});


function showToast(str){
    $("#toast").addClass("display");
    $("#toast").html(str);
    setTimeout(()=>{
        $("#toast").removeClass("display");
    },2000);
}
function checkOut(){
    if(localStorage.getItem("cart")!== null){
    window.location="checkout.jsp";}
    else{
        $(".cart-number").html("(0)");
        $(".cart-body").html("<h4>cart is empty</h4>");
        $(".checkout-btn").addClass("disabled");
    }
}
function deleteStorage(){
   newCart = JSON.parse(localStorage.getItem("cart"));
   let pId="";
   let pPrice="";
   let pQuentity="";
   let pName="";
   newCart.map((item)=>{
       pId=pId+item.productId+",";
       pQuentity= pQuentity+item.productQuentity+",";
       pName= pName+item.productName+",";
       pPrice = pPrice+item.productPrice+",";
   });
   $(".pId").val(`${pId}`);
   $(".pQuentity").val(`${pQuentity}`);
   $(".pName").val(`${pName}`);
   $(".pPrice").val(`${pPrice}`);
   console.log(pId);
   localStorage.removeItem("cart");
   $(".cart-number").html("(0)");
   $(".cart-body").html("<h4>cart is empty</h4>");
   $(".order-btn").addClass("disabled");
}
function continueShopping(){
    window.location="index.jsp";
}

function decreaseItemFromCart(pId){
    let cart = localStorage.getItem("cart");
    let newCart = JSON.parse(cart);
    let oldProduct = newCart.find((item) =>item.productId === pId);
    oldProduct.productQuentity=oldProduct.productQuentity-1;
    if(oldProduct.productQuentity>0){
        localStorage.setItem("cart",JSON.stringify(newCart));
        showToast(oldProduct.productName+" quantity decreased, Quantity ="+oldProduct.productQuentity);
        updateCart();
    }
    else{
        let newCart2 =[];
        newCart2=newCart.filter((item)=>item.productId !== pId);
        localStorage.setItem('cart',JSON.stringify(newCart2));
        showToast("Item is removed from the cart");
        updateCart();
    }
}

function changeUserDeletevalue(){
    console.log("prssed");
    $("#userDelete").val("1");
}
