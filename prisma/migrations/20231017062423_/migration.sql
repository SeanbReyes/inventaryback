-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Unidades" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "id_articulo" INTEGER NOT NULL,
    "precio_de_compra" INTEGER NOT NULL,
    "precio_de_venta" INTEGER,
    "numero_de_factura" INTEGER NOT NULL,
    "fecha_de_creacion" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "fecha_de_rebaja" DATETIME,
    "cliente_compra" TEXT NOT NULL,
    "cliente_venta" TEXT
);
INSERT INTO "new_Unidades" ("cliente_compra", "cliente_venta", "fecha_de_creacion", "fecha_de_rebaja", "id", "id_articulo", "numero_de_factura", "precio_de_compra") SELECT "cliente_compra", "cliente_venta", "fecha_de_creacion", "fecha_de_rebaja", "id", "id_articulo", "numero_de_factura", "precio_de_compra" FROM "Unidades";
DROP TABLE "Unidades";
ALTER TABLE "new_Unidades" RENAME TO "Unidades";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
