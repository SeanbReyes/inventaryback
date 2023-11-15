let exp = require("express")
let router = exp.Router()

let {PrismaClient} =  require('@prisma/client') 


let prisma  = new PrismaClient()



router.get('/uni',async(req,res)=>{
    console.log(req.query)
    req.query.id_articulo ? req.query.id_articulo = parseInt(req.query.id_articulo) : null
    req.query.numero_de_factura ? req.query.numero_de_factura = parseInt(req.query.numero_de_factura) : null
    req.query.vendido == 'false' ? req.query.vendido = false : null
    let uni = await prisma.unidades.findMany({
        where:req.query
    })
    for(let x of uni){
        let n = await prisma.articulo.findFirst({
            where:{id:x.id_articulo},
            select:{name:true}
        })
        x.name = n.name
    }
    return res.json({
        uni 
    })
})

router.get('/uni/cc/:numero_de_factura',async(req,res)=>{
    let numero_de_factura = parseInt(req.params['numero_de_factura'])
    let unis = await prisma.unidades.findMany({
        where:{numero_de_factura}
    })
    for(let x of unis){
        let name = await prisma.articulo.findFirst({
            where:{id:x.id_articulo},
            select:{name:true}
        })
        x.name = name.name
    }
    return res.send(unis)

})

router.get('/uni/vv/:numero_de_factura_venta',async(req,res)=>{
    let numero_de_factura_venta = parseInt(req.params['numero_de_factura_venta'])
    let unis = await prisma.unidades.findMany({
        where:{numero_de_factura_venta}
    })
    for(let x of unis){
        let name = await prisma.articulo.findFirst({
            where:{id:x.id_articulo},
            select:{name:true}
        })
        x.name = name.name
    }
    return res.send(unis)

})

router.get('/uni/:id',async(req,res)=>{
    try{
        return res.json({
            "unidad": await prisma.unidades.findFirst({where:{id:parseInt(req.params['id'])}})
        })
    }
    catch(e){
        console.log(e)
        return res.status(404).json({
            "unidad": null
        })
    }
    
})

router.post('/uni',async(req,res)=>{
    let unis = []
    for(let x = 0;x<req.headers.am;x++){
        unis.push(await prisma.unidades.create({data:req.body}))
    }
    return res.json({
        unis
    })
})

router.put('/uni/:id',async(req,res)=>{
    let unidad
    req.body.precio_de_compra = parseInt(req.body.precio_de_compra)
    req.body.numero_de_factura = parseInt(req.body.numero_de_factura)

    try{
        unidad = await prisma.unidades.update({
            where:{id:parseInt(req.params['id'])},
            data:req.body
        })
    }
    catch(e){
        console.log(e)
        return res.json({
            "unidad":null
        })
    }
    return res.json({
        unidad
    })
})

router.delete('/uni/:id',async(req,res)=>{
    try{
        await prisma.unidades.delete({
            where:{id:parseInt(req.params['id'])}
        })
    }
    catch(e){
        return res.status(400).json({
            "unidad":null
        })
    }
    return res.json({
        "unidad":"Eliminada"
    })
})


module.exports = router