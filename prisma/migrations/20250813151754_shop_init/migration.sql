/*
  Warnings:

  - You are about to drop the column `adresse` on the `Client` table. All the data in the column will be lost.
  - You are about to drop the column `adresse` on the `Fournisseur` table. All the data in the column will be lost.
  - You are about to drop the column `address` on the `Shop` table. All the data in the column will be lost.
  - You are about to drop the column `city` on the `Shop` table. All the data in the column will be lost.
  - You are about to drop the column `country` on the `Shop` table. All the data in the column will be lost.
  - You are about to drop the column `postalCode` on the `Shop` table. All the data in the column will be lost.
  - You are about to drop the column `address` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `city` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `country` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `postalCode` on the `User` table. All the data in the column will be lost.

*/
-- CreateTable
CREATE TABLE "Adresse" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "address" TEXT,
    "city" TEXT,
    "postalCode" TEXT,
    "country" TEXT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL
);

-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Client" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "nom" TEXT NOT NULL,
    "email" TEXT,
    "telephone" TEXT,
    "adresseId" TEXT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "shopId" TEXT,
    CONSTRAINT "Client_adresseId_fkey" FOREIGN KEY ("adresseId") REFERENCES "Adresse" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Client_shopId_fkey" FOREIGN KEY ("shopId") REFERENCES "Shop" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_Client" ("createdAt", "email", "id", "nom", "shopId", "telephone", "updatedAt") SELECT "createdAt", "email", "id", "nom", "shopId", "telephone", "updatedAt" FROM "Client";
DROP TABLE "Client";
ALTER TABLE "new_Client" RENAME TO "Client";
CREATE TABLE "new_Fournisseur" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "nom" TEXT NOT NULL,
    "email" TEXT,
    "telephone" TEXT,
    "adresseId" TEXT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "shopId" TEXT,
    CONSTRAINT "Fournisseur_adresseId_fkey" FOREIGN KEY ("adresseId") REFERENCES "Adresse" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Fournisseur_shopId_fkey" FOREIGN KEY ("shopId") REFERENCES "Shop" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_Fournisseur" ("createdAt", "email", "id", "nom", "shopId", "telephone", "updatedAt") SELECT "createdAt", "email", "id", "nom", "shopId", "telephone", "updatedAt" FROM "Fournisseur";
DROP TABLE "Fournisseur";
ALTER TABLE "new_Fournisseur" RENAME TO "Fournisseur";
CREATE TABLE "new_Shop" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "adresseId" TEXT,
    "telephone" TEXT,
    "email" TEXT,
    "website" TEXT,
    "logo" TEXT,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    CONSTRAINT "Shop_adresseId_fkey" FOREIGN KEY ("adresseId") REFERENCES "Adresse" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_Shop" ("createdAt", "description", "email", "id", "isActive", "logo", "name", "telephone", "updatedAt", "website") SELECT "createdAt", "description", "email", "id", "isActive", "logo", "name", "telephone", "updatedAt", "website" FROM "Shop";
DROP TABLE "Shop";
ALTER TABLE "new_Shop" RENAME TO "Shop";
CREATE UNIQUE INDEX "Shop_name_key" ON "Shop"("name");
CREATE TABLE "new_User" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "firstName" TEXT,
    "lastName" TEXT,
    "birthDate" DATETIME,
    "username" TEXT,
    "email" TEXT,
    "password" TEXT,
    "telephone" TEXT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "roleId" TEXT NOT NULL,
    "shopId" TEXT NOT NULL,
    "adresseId" TEXT,
    CONSTRAINT "User_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES "UserRole" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "User_shopId_fkey" FOREIGN KEY ("shopId") REFERENCES "Shop" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "User_adresseId_fkey" FOREIGN KEY ("adresseId") REFERENCES "Adresse" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_User" ("birthDate", "createdAt", "email", "firstName", "id", "lastName", "password", "roleId", "shopId", "telephone", "updatedAt", "username") SELECT "birthDate", "createdAt", "email", "firstName", "id", "lastName", "password", "roleId", "shopId", "telephone", "updatedAt", "username" FROM "User";
DROP TABLE "User";
ALTER TABLE "new_User" RENAME TO "User";
CREATE UNIQUE INDEX "User_username_key" ON "User"("username");
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");
CREATE UNIQUE INDEX "User_roleId_key" ON "User"("roleId");
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
