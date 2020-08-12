module.exports = (srv) => {

    const {Products} = cds.entities ('ecommerce.system')
  
    // Reduce stock of ordered products
    srv.before ('CREATE', 'Orders', async (req) => {
      const order = req.data
      if (!order.amount || order.amount <= 0)  return req.error (400, 'Order at least 1 book')
      const tx = cds.transaction(req)
      const affectedRows = await tx.run (
        UPDATE (Products)
          .set   ({ stock: {'-=': order.amount}})
          .where ({ stock: {'>=': order.amount},/*and*/ ID: order.product_ID})
      )
      if (affectedRows === 0)  req.error (409, "Sold out, sorry")
    })
  
    // Add some discount for overstocked products
    srv.after ('READ', 'Products', each => {
      if (each.stock > 111)  each.title += ' -- 11% discount!'
    })
  
  }