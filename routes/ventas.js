let exp = require("express")
let router = exp.Router()
let {PrismaClient} =  require('@prisma/client') 


let prisma  = new PrismaClient()


router.get('/venta',async(req,res)=>{
    return res.json({
        Ventas:await prisma.factura_Venta.findMany()
    })
})

router.post('/venta',async(req,res)=>{

    try{
        let unidades = req.body.unidades
        console.log(unidades)
    let unis_id = ''
    let gn = 0
    for(let x of unidades){
        unis_id += `${x},`
        let uni = await prisma.unidades.update({
            where:{id:x},
            data:{
                fecha_de_venta:req.body.date,
                vendido:true,
                cliente_venta:req.body.cliente,
                numero_de_factura_venta:parseInt(req.body.no_factura)
            }
        })
        gn += uni.precio_de_compra
    }
    unis_id = unis_id.slice(0,-1)
    await prisma.factura_Venta.create({
        data:{
            products_id:unis_id,
            num_factura:parseInt(req.body.no_factura),
            precio:parseInt(req.body.precio),
            cliente:req.body.cliente,
            ganancia:req.body.precio - gn,
            fecha:req.body.date
        }
    })

    return res.json({
        message:"Venta Realizada"
    })
    }
    catch(e){
        console.log(e)
        return res.status(400).json({
            message:"Venta No Realizada"
        })
    }

    

})

router.get('/venta/:id',async(req,res)=>{
    let unidades = []
    let venta = await prisma.factura_Venta.findFirst({
        where:{id:parseInt(req.params['id'])}
    })
    unidades = JSON.parse("[" + venta.products_id + "]");

    let unis = []
    for(let x of unidades){
        unis.push(await prisma.unidades.findFirst({
            where:{id:x}
        }))
    }
    for(let x of unis){
        let name = await prisma.articulo.findFirst({where:{id:x.id_articulo},select:{name:true}})
        x.art_name = name
    }

    return res.json({
        venta,
        unidades:unis
    })

})

router.put('/venta/:id',async(req,res)=>{
    req.body.data.num_factura = parseInt(req.body.data.num_factura)
    req.body.data.precio = parseInt(req.body.data.precio)
    req.body.data.ganancia = parseInt(req.body.data.ganancia)
    return res.json({
        venta: await prisma.factura_Venta.update({
            where:{id:parseInt(req.params['id'])},
            data:req.body.data
        })
    })
})

router.delete('/venta/:id',async(req,res)=>{
    return res.json({
        venta : await prisma.factura_Venta.delete({
            where:{id:parseInt(req.params['id'])}
        })
    })
})


module.exports = router