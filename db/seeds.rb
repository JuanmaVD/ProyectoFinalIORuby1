# require 'date'

# cliente1=Client.create(nombreCliente: "Cliente1", apellidoCliente: "Apellido1", mailCliente:"mail1@gmail.com", telefonoCliente: 2615342446) 
# cliente2=Client.create(nombreCliente: "Cliente2", apellidoCliente: "Apellido2", mailCliente:"mail2@gmail.com", telefonoCliente: 2615342447) 
# cliente3=Client.create(nombreCliente: "Cliente3", apellidoCliente: "Apellido3", mailCliente:"mail3@gmail.com", telefonoCliente: 2615342448) 
# cliente4=Client.create(nombreCliente: "Cliente4", apellidoCliente: "Apellido4", mailCliente:"mail4@gmail.com", telefonoCliente: 2615342449) 
# cliente5=Client.create(nombreCliente: "Cliente5", apellidoCliente: "Apellido5", mailCliente:"mail5@gmail.com", telefonoCliente: 2615342442)   

# sale1=Sale.create(totalCostoVenta: 40, estadoVenta: "Pendiente", client_id:cliente1.id) 
# sale2=Sale.create(totalCostoVenta: 50, estadoVenta: "Terminado", client_id:cliente2.id) 
# sale3=Sale.create(totalCostoVenta: 60, estadoVenta: "Recibido", client_id:cliente3.id) 
# sale4=Sale.create(totalCostoVenta: 70, estadoVenta: "Pendiente", client_id:cliente4.id)   
# sale5=Sale.create(totalCostoVenta: 80, estadoVenta: "Recibido", client_id:cliente5.id)   

# categoria1=Category.create(nombreCategoria:"nombreCategoria1",descripcionCategoria:"descripcionCategoria1")  
# categoria2=Category.create(nombreCategoria:"nombreCategoria2",descripcionCategoria:"descripcionCategoria2") 
# categoria3=Category.create(nombreCategoria:"nombreCategoria3",descripcionCategoria:"descripcionCategoria3") 
# categoria4=Category.create(nombreCategoria:"nombreCategoria4",descripcionCategoria:"descripcionCategoria4")
# categoria5=Category.create(nombreCategoria:"nombreCategoria5",descripcionCategoria:"descripcionCategoria5")  

# product1=Product.create(nombreProducto: "Pantalon", descripcionProducto: "Pantalon para hombre", precioProveedorProducto: 40, precioVentaProducto: 80, category_id:categoria1.id ) 
# product2=Product.create(nombreProducto: "Producto1", descripcionProducto: "Descripcion1", precioProveedorProducto: 50, precioVentaProducto: 100, category_id:categoria2.id )  
# product3=Product.create(nombreProducto: "Producto2", descripcionProducto: "Descripcion2", precioProveedorProducto: 60, precioVentaProducto: 120, category_id:categoria3.id ) 
# product4=Product.create(nombreProducto: "Producto3", descripcionProducto: "Descripcion3", precioProveedorProducto: 70, precioVentaProducto: 140, category_id:categoria4.id )  
# product5=Product.create(nombreProducto: "Producto4", descripcionProducto: "Descripcion4", precioProveedorProducto: 80, precioVentaProducto: 160, category_id:categoria5.id )   

 

# ProductSale.create(totalCostoVentaProducto: 40, cantVentaProducto: 20, subTotalVentaProducto: 800, product_id: product1.id, sale_id: sale1.id)  
# ProductSale.create(totalCostoVentaProducto: 50, cantVentaProducto: 10, subTotalVentaProducto: 500, product_id: product2.id, sale_id: sale2.id)
# ProductSale.create(totalCostoVentaProducto: 70, cantVentaProducto: 20, subTotalVentaProducto: 1400, product_id: product3.id, sale_id: sale3.id) 
# ProductSale.create(totalCostoVentaProducto: 10, cantVentaProducto: 80, subTotalVentaProducto: 800, product_id: product4.id, sale_id: sale4.id)   
# ProductSale.create(totalCostoVentaProducto: 80, cantVentaProducto: 80, subTotalVentaProducto: 6400, product_id: product5.id,sale_id: sale5.id)      

# proveedor1=Provider.create(nombreProveedor: "Proveedor1")  
# proveedor2=Provider.create(nombreProveedor: "Proveedor2")
# proveedor3=Provider.create(nombreProveedor: "Proveedor3")
# proveedor4=Provider.create(nombreProveedor: "Proveedor4")  
# proveedor5=Provider.create(nombreProveedor: "Proveedor5")    

# purchaseOrder1=PurchaseOrder.create(totalCostoOrdenCompra: 80, estadoOrdenCompra:  "Terminada", fechaEstimadaEntrega: Date.today)  
# purchaseOrder2=PurchaseOrder.create(totalCostoOrdenCompra: 90, estadoOrdenCompra:  "Pendiente de pago", fechaEstimadaEntrega: Date.today, provider_id:proveedor2.id)  
# purchaseOrder3=PurchaseOrder.create(totalCostoOrdenCompra: 100, estadoOrdenCompra:  "Pendiente de pago", fechaEstimadaEntrega: Date.today, provider_id:proveedor3.id)  
# purchaseOrder4=PurchaseOrder.create(totalCostoOrdenCompra: 110, estadoOrdenCompra:  "Terminada", fechaEstimadaEntrega: Date.today, provider_id:proveedor4.id) 
# purchaseOrder5=PurchaseOrder.create(totalCostoOrdenCompra: 120, estadoOrdenCompra:  "Terminada", fechaEstimadaEntrega: Date.today, provider_id:proveedor5.id)   

# ProductPurchaseOrder.create(totalCostoOrdenCompraProducto: 70, cantOrdenCompraProducto: 70, subTotalCostoOrdenCompraProducto: 10, product_id: product1.id, purchase_order_id: purchaseOrder1.id)  
# ProductPurchaseOrder.create(totalCostoOrdenCompraProducto: 80, cantOrdenCompraProducto: 80, subTotalCostoOrdenCompraProducto: 9, product_id: product2.id, purchase_order_id: purchaseOrder2.id) 
# ProductPurchaseOrder.create(totalCostoOrdenCompraProducto: 90, cantOrdenCompraProducto: 90, subTotalCostoOrdenCompraProducto: 8, product_id: product3.id, purchase_order_id: purchaseOrder3.id) 
# ProductPurchaseOrder.create(totalCostoOrdenCompraProducto: 100, cantOrdenCompraProducto: 100, subTotalCostoOrdenCompraProducto: 7, product_id: product4.id, purchase_order_id: purchaseOrder4.id)
# ProductPurchaseOrder.create(totalCostoOrdenCompraProducto: 110, cantOrdenCompraProducto: 110, subTotalCostoOrdenCompraProducto: 6, product_id: product5.id,purchase_order_id: purchaseOrder5.id)

# puts("se cargo la seed")

