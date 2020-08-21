const cds = require('@sap/cds')

/** Service implementation for CustomerService */
module.exports = cds.service.impl(async function () {
  const { Products, Orders, ExternalProducts } = this.entities
  const prodSrv = await cds.connect.to('EPM_REF_APPS_PROD_MAN_SRV')
  this.after('READ', Products, each => each.stock > 111 && _addDiscount2(each, 11))
  this.before('CREATE', Orders, _reduceStock)
  this.on('READ', ExternalProducts, req => prodSrv.tx(req).run(req.query))

  /** Add some discount for overstocked books */
  function _addDiscount2(each, discount) {
    each.productName += ` -- ${discount}% discount!`
  }

  /** Reduce stock of ordered books if available stock suffices */
  async function _reduceStock(req) {
    const { items: OrderItems } = req.data
    return cds.transaction(req).run(() => OrderItems.map(order =>
      UPDATE(Products).set('stock -=', order.amount)
        .where('ID =', order.product_ID).and('stock >=', order.amount)
    )).then(all => all.forEach((affectedRows, i) => {
      if (affectedRows === 0) req.error(409,
        `${OrderItems[i].amount} exceeds stock for book #${OrderItems[i].product_ID}`
      )
    }))
  }
})