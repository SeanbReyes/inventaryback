let exp = require("express")
let router = exp.Router()

let {PrismaClient} =  require('@prisma/client') 


let prisma  = new PrismaClient()



router.get('/uni',async(req,res)=>{
    console.log(req.query)
    req.query.id_articulo ? req.query.id_articulo = parseInt(req.query.id_articulo) : null
    let uni = await prisma.unidades.findMany({
        where:req.query
    })
    return res.json({
        uni 
    })
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