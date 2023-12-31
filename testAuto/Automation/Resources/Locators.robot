*** Variables ***
${USERNAME_LOC}    id:user-name
${PASSWORD_LOC}    id:password
${LOGINBUTTON}    id:login-button
${PRODUCTLIST_LOC}    //div[@class='inventory_list']/div[@class='inventory_item']
${FIRSTNAME_LOC}    //input[@id='first-name']
${LASTNAME_LOC}    //input[@id='last-name']
${ZIPCODE_LOC}    //input[@id='postal-code']
${PRODUCTS_TEXT}    //span[contains(text(),'Products')]
${CONTINUE_BUTTON}    //input[@id='continue']
${CHECKOUT_OVERVIEW}    //span[contains(text(),'Checkout: Overview')]
${CART_LOCATOR}    //body/div[@id='root']/div[@id='page_wrapper']/div[@id='contents_wrapper']/div[@id='header_container']/div[1]/div[3]/a[1]
${FINISH_BUTTON}    //button[@id='finish']
${BAGPACK_BUTTON}    //button[@id='add-to-cart-sauce-labs-backpack']
${BIKELIGHT_BUTTON}    //button[@id='add-to-cart-sauce-labs-bike-light']
${TSHIRT_BUTTON}    //button[@id='add-to-cart-sauce-labs-bolt-t-shirt']
${JACKET_BUTTON}    //button[@id='add-to-cart-sauce-labs-fleece-jacket']
${ONESIE_BUTTON}    //button[@id='add-to-cart-sauce-labs-onesie']
${RED_TSHIRT_BUTTON}    //button[@id='add-to-cart-test.allthethings()-t-shirt-(red)']
${PRODUCT_NAME_CART_QTY1}    //div[@class='cart_list']/div[3][1]/div[2]/a[1]/div[1]
${PRODUCT_PRICE_CART_QTY1}    //div[@class='cart_list']/div[3][1]/div[2]/div[2]/div[1]
${FINALPRICE_LOC}    //div[@class='summary_info']/div[@class='summary_info_label summary_total_label']
${CHECKOUT_BUTTON}    //button[@id='checkout']
${CARTPAGE_LOC}    //span[contains(text(),'Your Cart')]
${YOURINFO_LOC}    //span[contains(text(),'Checkout: Your Information')]
${THANKYOU_MSG}    //h2[contains(text(),'Thank you for your order!')]
${LOGOUT_BUTTON}    //a[@id='logout_sidebar_link']
${MENU_BUTTON}    //button[@id='react-burger-menu-btn']
${HOMEPAGE}       //div[contains(text(),'Swag Labs')]
${CUST_INFO_ERROR_MSG_LOC}    //body/div[@id='root']/div[@id='page_wrapper']/div[@id='contents_wrapper']/div[@id='checkout_info_container']/div[1]/form[1]/div[1]/div[4]/h3[1]
