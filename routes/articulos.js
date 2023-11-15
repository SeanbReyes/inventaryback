let exp = require("express")
let router = exp.Router()
let {PrismaClient} =  require('@prisma/client') 


let prisma  = new PrismaClient()


router.get('/arts',async(req,res)=>{
    req.query.id ? req.query.id = parseInt(req.query.id) : null
    let articulos = await prisma.articulo.findMany()
    
    for(let x of articulos){
        x.disponibles = await prisma.unidades.count({
            where:{id_articulo:parseInt(x.id),vendido:false}
        })

    }
    let total = 0
    for(let x of articulos){
        let f = await prisma.unidades.findMany({
            where:{id_articulo:parseInt(x.id)}
        })
        for(let p of f){
           x.valor_total += p.precio_de_compra
        }


    }

    return res.json({
        articulos
    })
    
})
router.get('/arts/:id',async(req,res)=>{
    let articulo = await prisma.articulo.findUnique({
        where:{id:parseInt(req.params['id'])}
    })
    if(articulo === null){
        return res.json({
            articulo
        })
    }
    articulo.disponibles = await prisma.unidades.findMany({
        where:{id_articulo:parseInt(articulo.id)}
    })
    for(let x of articulo.disponibles){
        articulo.valor_total += x.precio_de_compra
    }
    return res.json({
        articulo
    })
})

router.post('/arts',async(req,res)=>{
    return res.json({
        "articulos":await prisma.articulo.create({
            data:req.body
        })
    })
})

router.put('/arts/:id',async(req,res)=>{
    let articulo
    console.log(req.body)
    try{
        articulo = await prisma.articulo.update({
            where:{id:parseInt(req.params['id'])},
            data:req.body
        })
    }
    catch(e){
        return res.json({
            "articulo":null
        })
    }
    return res.json({
        articulo
    })
})

router.delete('/arts/:id',async(req,res)=>{
    try{
        await prisma.articulo.delete({
            where:{id:parseInt(req.params['id'])}
        })
    }
    catch(e){
        return res.status(404).json({
            "articulo":"Not Found"
        })
    }
    
    
    await prisma.unidades.deleteMany({
        where:{id_articulo:parseInt(req.params.id)}
    })
    

    return res.json({
        "articulo": "eliminado"
    })
})



module.exports = router