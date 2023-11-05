-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Articulo" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "valor_total" INTEGER,
    "disponibles" INTEGER
);
INSERT INTO "new_Articulo" ("disponibles", "id", "name", "valor_total") SELECT "disponibles", "id", "name", "valor_total" FROM "Articulo";
DROP TABLE "Articulo";
ALTER TABLE "new_Articulo" RENAME TO "Articulo";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
