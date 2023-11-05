-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Unidades" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "id_articulo" INTEGER NOT NULL,
    "precio_de_compra" INTEGER NOT NULL,
    "precio_de_venta" INTEGER,
    "numero_de_factura" INTEGER NOT NULL,
    "fecha_de_creacion" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "fecha_de_modificacion" DATETIME,
    "fecha_de_rebaja" DATETIME,
    "vendido" BOOLEAN DEFAULT false,
    "cliente_compra" TEXT NOT NULL,
    "cliente_venta" TEXT,
    CONSTRAINT "Unidades_id_articulo_fkey" FOREIGN KEY ("id_articulo") REFERENCES "Articulo" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Unidades" ("cliente_compra", "cliente_venta", "fecha_de_creacion", "fecha_de_modificacion", "fecha_de_rebaja", "id", "id_articulo", "numero_de_factura", "precio_de_compra", "precio_de_venta", "vendido") SELECT "cliente_compra", "cliente_venta", "fecha_de_creacion", "fecha_de_modificacion", "fecha_de_rebaja", "id", "id_articulo", "numero_de_factura", "precio_de_compra", "precio_de_venta", "vendido" FROM "Unidades";
DROP TABLE "Unidades";
ALTER TABLE "new_Unidades" RENAME TO "Unidades";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
