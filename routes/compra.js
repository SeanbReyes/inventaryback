let exp = require("express")
let router = exp.Router()
let {PrismaClient} =  require('@prisma/client') 



let prisma  = new PrismaClient()


router.get('/compra',async(req,res)=>{
    return res.json({
        Compras:await prisma.factura_Compra.findMany()
    })

})

router.post('/compra',async(req,res)=>{
    console.log(req.body)
    let model_names = req.body.names
    let unidades = req.body.unidades
    let unidades_id = ''
    for(let x of model_names){
        await prisma.articulo.upsert({
            where:{name:x},
            create:{name:x},
            update:{name:x}
        })
    }
    for(let x of unidades){
        let art_id = await prisma.articulo.findFirst({
            where:{name:x.art_id}
        })
        art_id = art_id.id
        for(let y = 0;y < x.cantidad;y++){
            let data = {
                id_articulo : art_id,
                precio_de_compra : x.precio_de_compra,
                numero_de_factura : req.body.no_factura,
                cliente_compra : req.body.proveedor
            }
            let unid = await prisma.unidades.create({
                data
            })
            
            unidades_id += `${unid.id},`
        }

    }
    unidades_id = unidades_id.slice(0,-1)
    await prisma.factura_Compra.create({
        data:{
            proveedor:req.body.proveedor,
            num_factura:req.body.no_factura,
            products_id:unidades_id,
            costo:req.body.costo
        }
    })

    return res.json({
        "message":"Compra Realizada"
    })



    
})

router.get('/compra/:id',async(req,res)=>{
    let unidades = []
    let compra = await prisma.factura_Compra.findFirst({
        where:{id:parseInt(req.params['id'])}
    })
    unidades = JSON.parse("[" + compra.products_id + "]");
    let unis = []
    for(let x of unidades){
        let some = await prisma.unidades.findFirst({
            where:{id:x}
        })
        unis.push(some)
    }
    for(let x of unis){
        let name = await prisma.articulo.findFirst({where:{id:x.id_articulo},select:{name:true}})
        x.art_name = name
    }

    return res.json({
        compra,
        unidades:unis
    })
})

router.put('/compra/:id',async(req,res)=>{
    return res.json({
        compra: await prisma.factura_Compra.update({
            where:{id:parseInt(req.params['id'])},
            data:req.body.data
        })
    })
})

router.delete('/compra/:id',async(req,res)=>{
    return res.json({
        compra : await prisma.factura_Compra.delete({
            where:{id:parseInt(req.params['id'])}
        })
    })
})


module.exports = router