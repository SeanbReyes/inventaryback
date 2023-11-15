-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Factura_Compra" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "proveedor" TEXT NOT NULL,
    "num_factura" INTEGER NOT NULL,
    "products_id" TEXT NOT NULL,
    "costo" INTEGER NOT NULL,
    "fecha" TEXT NOT NULL
);
INSERT INTO "new_Factura_Compra" ("costo", "fecha", "id", "num_factura", "products_id", "proveedor") SELECT "costo", "fecha", "id", "num_factura", "products_id", "proveedor" FROM "Factura_Compra";
DROP TABLE "Factura_Compra";
ALTER TABLE "new_Factura_Compra" RENAME TO "Factura_Compra";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
