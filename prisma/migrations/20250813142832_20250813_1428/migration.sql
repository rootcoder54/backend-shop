/*
  Warnings:

  - You are about to drop the column `commandeId` on the `Client` table. All the data in the column will be lost.
  - You are about to drop the column `image` on the `Produit` table. All the data in the column will be lost.
  - You are about to drop the column `compteId` on the `User` table. All the data in the column will be lost.
  - Added the required column `shopId` to the `User` table without a default value. This is not possible if the table is not empty.

*/
-- CreateTable
CREATE TABLE "Image" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "url" TEXT NOT NULL,
    "produitId" TEXT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    CONSTRAINT "Image_produitId_fkey" FOREIGN KEY ("produitId") REFERENCES "Produit" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "_ClientToCommande" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL,
    CONSTRAINT "_ClientToCommande_A_fkey" FOREIGN KEY ("A") REFERENCES "Client" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "_ClientToCommande_B_fkey" FOREIGN KEY ("B") REFERENCES "Commande" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Client" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "nom" TEXT NOT NULL,
    "email" TEXT,
    "telephone" TEXT,
    "adresse" TEXT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "shopId" TEXT,
    CONSTRAINT "Client_shopId_fkey" FOREIGN KEY ("shopId") REFERENCES "Shop" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_Client" ("adresse", "createdAt", "email", "id", "nom", "shopId", "telephone", "updatedAt") SELECT "adresse", "createdAt", "email", "id", "nom", "shopId", "telephone", "updatedAt" FROM "Client";
DROP TABLE "Client";
ALTER TABLE "new_Client" RENAME TO "Client";
CREATE TABLE "new_Produit" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "nom" TEXT NOT NULL,
    "description" TEXT,
    "prix" REAL NOT NULL,
    "quantite" INTEGER NOT NULL,
    "fournisseurId" TEXT,
    "categorieId" TEXT,
    "shopId" TEXT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    CONSTRAINT "Produit_fournisseurId_fkey" FOREIGN KEY ("fournisseurId") REFERENCES "Fournisseur" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Produit_categorieId_fkey" FOREIGN KEY ("categorieId") REFERENCES "Categorie" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Produit_shopId_fkey" FOREIGN KEY ("shopId") REFERENCES "Shop" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_Produit" ("categorieId", "createdAt", "description", "fournisseurId", "id", "nom", "prix", "quantite", "shopId", "updatedAt") SELECT "categorieId", "createdAt", "description", "fournisseurId", "id", "nom", "prix", "quantite", "shopId", "updatedAt" FROM "Produit";
DROP TABLE "Produit";
ALTER TABLE "new_Produit" RENAME TO "Produit";
CREATE TABLE "new_User" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "firstName" TEXT,
    "lastName" TEXT,
    "birthDate" DATETIME,
    "address" TEXT,
    "city" TEXT,
    "postalCode" TEXT,
    "country" TEXT,
    "username" TEXT,
    "email" TEXT,
    "password" TEXT,
    "telephone" TEXT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "roleId" TEXT NOT NULL,
    "shopId" TEXT NOT NULL,
    CONSTRAINT "User_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES "UserRole" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "User_shopId_fkey" FOREIGN KEY ("shopId") REFERENCES "Shop" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_User" ("address", "birthDate", "city", "country", "createdAt", "email", "firstName", "id", "lastName", "password", "postalCode", "roleId", "telephone", "updatedAt", "username") SELECT "address", "birthDate", "city", "country", "createdAt", "email", "firstName", "id", "lastName", "password", "postalCode", "roleId", "telephone", "updatedAt", "username" FROM "User";
DROP TABLE "User";
ALTER TABLE "new_User" RENAME TO "User";
CREATE UNIQUE INDEX "User_username_key" ON "User"("username");
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");
CREATE UNIQUE INDEX "User_roleId_key" ON "User"("roleId");
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;

-- CreateIndex
CREATE UNIQUE INDEX "_ClientToCommande_AB_unique" ON "_ClientToCommande"("A", "B");

-- CreateIndex
CREATE INDEX "_ClientToCommande_B_index" ON "_ClientToCommande"("B");
