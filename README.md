# Conception-Base-de-Donn-es-avec-PostgreSQL
# 🚢 Système de Gestion Portuaire et Maritime

## 📋 Présentation du Projet

Ce projet implémente un système complet de gestion portuaire et maritime permettant de gérer efficacement les ports, les routes maritimes, les navires, les expéditions, les conteneurs et les événements liés aux opérations maritimes. Il offre une solution intégrée pour le suivi en temps réel des opérations portuaires et la traçabilité complète des conteneurs.

### 🔗 Suivi du Projet

**Tableau Trello** : [Lien vers le board Trello][(https://trello.com/b/votre-board)](https://trello.com/invite/b/694404616517b8cea6fbbdd4/ATTI425583d190c643bd21eb414716abd9575587C571/bref-6)


---

## 🎯 Objectifs du Projet

### Objectifs Principaux

1. **Gestion Centralisée des Ports**
   - Centraliser les informations de tous les ports
   - Gérer les capacités et les catégories
   - Suivre l'état d'activité des ports

2. **Optimisation des Routes Maritimes**
   - Définir et gérer les routes maritimes
   - Planifier les escales avec précision
   - Optimiser les distances et durées

3. **Suivi des Expéditions**
   - Tracer le parcours complet des expéditions
   - Gérer les segments de transport
   - Suivre les dates de départ et d'arrivée

4. **Gestion des Conteneurs**
   - Suivre l'état en temps réel de chaque conteneur
   - Historiser tous les changements de statut
   - Gérer les inspections et la maintenance

5. **Gestion des Événements**
   - Enregistrer tous les incidents et alertes
   - Classifier par niveau de gravité
   - Assurer l'immuabilité des événements

6. **Intégrité et Traçabilité**
   - Garantir la cohérence des données
   - Tracer toutes les modifications
   - Assurer la conformité réglementaire

---

## 🔍 Périmètre Fonctionnel

### Modules Fonctionnels

#### 1. Gestion des Ports
- ✅ Création et modification des ports
- ✅ Classification par catégorie (commercial, industriel, etc.)
- ✅ Gestion de la capacité et de l'état d'activité
- ✅ Localisation géographique

#### 2. Gestion des Routes Maritimes
- ✅ Définition des routes entre ports
- ✅ Configuration de la fréquence des trajets
- ✅ Gestion des escales avec ordre séquentiel
- ✅ Calcul des distances et durées

#### 3. Gestion des Navires
- ✅ Enregistrement des navires (numéro IMO)
- ✅ Suivi de la capacité et du type
- ✅ Gestion des armateurs
- ✅ État opérationnel des navires

#### 4. Gestion des Expéditions
- ✅ Création d'expéditions client
- ✅ Définition des ports d'origine et destination
- ✅ Suivi du statut (en cours, terminé, annulé)
- ✅ Segmentation du transport

#### 5. Gestion des Conteneurs
- ✅ Enregistrement avec code ISO
- ✅ Suivi du statut en temps réel
- ✅ Historisation automatique des changements
- ✅ Gestion des inspections

#### 6. Gestion des Événements
- ✅ Enregistrement des incidents
- ✅ Classification par gravité (mineur, majeur, critique)
- ✅ Association aux entités concernées
- ✅ Protection contre les modifications

#### 7. Historique et Traçabilité
- ✅ Historique complet des conteneurs
- ✅ Traçage des utilisateurs
- ✅ Horodatage automatique
- ✅ Audit trail complet


## 📊 Méthodologie

### Approche de Développement

Le projet suit une méthodologie **Agile** avec les principes suivants :

#### 1. Analyse et Conception
- Identification des besoins métier
- Modélisation conceptuelle (MCD)
- Définition des règles de gestion
- Validation avec les parties prenantes

#### 2. Modélisation des Données
- **MCD** : Modèle Conceptuel de Données
- **MLD** : Modèle Logique de Données
- **MRD** : Modèle Relationnel de Données
- Normalisation jusqu'à la 3NF

#### 3. Implémentation
- Création du schéma PostgreSQL
- Développement des contraintes d'intégrité
- Implémentation des triggers et fonctions
- Tests unitaires et d'intégration

#### 4. Validation
- Tests de validation des contraintes
- Tests des triggers
- Vérification de l'intégrité référentielle
- Tests de performance

#### 5. Documentation
- Documentation technique complète
- Guide d'utilisation
- Scripts d'installation
- Exemples d'utilisation

### Outils et Organisation

- **Gestion de projet** : Trello
- **Versioning** : Git / GitHub
- **Base de données** : PostgreSQL
- **Documentation** : readme
- **Diagrammes** : dbshema

---

## 🗂️ Modélisation du Projet

### Modèle Conceptuel de Données (MCD)

Le MCD représente la structure conceptuelle du système avec les entités principales et leurs relations.

![Modèle Conceptuel de Données](![WhatsApp Image 2025-12-18 à 15 33 00_1d5ce83e](https://github.com/user-attachments/assets/d4ad1f40-5ada-424b-9904-225c7d787d73)
)

#### Entités Principales

| Entité | Attributs Clés | Description |
|--------|---------------|-------------|
| **PORTS** | LoCode, Nom, Localisation | Points d'escale maritimes |
| **ROUTES** | ID_route, Nom, Fréquence | Trajets maritimes définis |
| **NAVIRES** | IMO, Nom, Capacité | Bateaux de transport |
| **CONTENEURS** | ISO, Type, Statut | Unités de transport |
| **EXPÉDITIONS** | ID_expedition, Client | Commandes de transport |
| **ÉVÉNEMENTS** | ID_evenement, Type | Incidents et alertes |
| **MARCHANDISES** | ID_marchandise, Nom | Produits transportés |

#### Relations Principales

- **CONTIENT** : Ports ↔ Escales ↔ Routes (1,1 - 1,N - 1,1)
- **UTILISE** : Navires ↔ Segments (0,N - 1,N)
- **INCLUE** : Expéditions ↔ Segments (1,1 - 1,N)
- **POSSÈDE** : Conteneurs ↔ Historiques (1,1 - 0,N)
- **CONCERNE** : Événements ↔ Entités (0,N)

### Règles de Gestion

1. Un port peut avoir plusieurs escales
2. Une route est composée de plusieurs escales ordonnées
3. L'ordre des escales doit être strictement positif
4. Un conteneur ne peut avoir qu'un seul statut à la fois
5. Chaque changement de statut est historisé automatiquement
6. Les événements ne peuvent jamais être modifiés après création
7. La date d'arrivée réelle doit être postérieure ou égale à la date de départ
8. Les statuts des conteneurs sont limités à 4 valeurs prédéfinies
9. La gravité des événements est limitée à 3 niveaux

---

## 🗄️ Modèle Logique de Données (MLD)

Le MLD traduit le MCD en structure de tables avec clés primaires et étrangères.

![Modèle Logique de Données](77777777777777777<img width="1143" height="639" alt="image" src="https://github.com/user-attachments/assets/5e5cc78b-1c04-413a-a5c1-f1c5917e3c39" />
)

### Structure des Tables
```
PORT (locode, nom, localisation, categorie, capacite, active, pays)
ROUTE (id_route, nom, frequence, active)
ESCALE (id_escal, #locode, #id_route, ordre, duree, distance)
NAVIRE (imo, nom, armateur, capacite, type, etat)
CONTENEUR (iso, type, statut, categorie, date_derni_inscreption, poids_max)
EXPEDITION (id_expedition, client, #id_port_origin, #id_port_destination, statut, date_creation)
SEGMENT (id_segments, #id_expedition, #imo, date_depart, arrivee_prévue, arrivee_reel)
EVENEMENT (id_evenement, type, description)
HISTORIQUE (id_historique, #iso, ancien_statut, nouv_statut, date, utilisateur)
MARCHANDISE (id_marchandise, nom, description, dangereux)
```


## 💾 Implémentation PostgreSQL

### Création du Schéma
```sql
-- Création du schéma
CREATE SCHEMA schema_;
SET search_path TO schema_;
```

### Tables Principales

#### Table PORTS
```sql
CREATE TABLE schema_.port (
    locode INTEGER PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    localisation VARCHAR(200),
    categorie VARCHAR(50),
    capacite VARCHAR(50),
    active BOOLEAN DEFAULT TRUE,
    pays VARCHAR(100)
);
```

#### Table ROUTES
```sql
CREATE TABLE schema_.route (
    id_route INTEGER PRIMARY KEY,
    nom VARCHAR(200) NOT NULL,
    frequence VARCHAR(50),
    active BOOLEAN DEFAULT TRUE
);
```

#### Table ESCALES
```sql
CREATE TABLE schema_.escale (
    id_escal INTEGER PRIMARY KEY,
    locode INTEGER NOT NULL,
    id_route INTEGER NOT NULL,
    ordre INTEGER NOT NULL,
    duree INTERVAL,
    distance NUMERIC(10,2),
    FOREIGN KEY (locode) REFERENCES schema_.port(locode),
    FOREIGN KEY (id_route) REFERENCES schema_.route(id_route)
);
```

#### Table NAVIRES
```sql
CREATE TABLE schema_.navire (
    imo INTEGER PRIMARY KEY,
    nom VARCHAR(200) NOT NULL,
    armateur VARCHAR(200),
    capacite INTEGER,
    type VARCHAR(50),
    etat VARCHAR(50)
);
```

#### Table CONTENEURS
```sql
CREATE TABLE schema_.conteneurs (
    iso INTEGER PRIMARY KEY,
    type VARCHAR(20) NOT NULL,
    statut VARCHAR(50) NOT NULL,
    categorie VARCHAR(50),
    date_derni_inscreption DATE,
    poids_max NUMERIC(10,2)
);
```

#### Table EXPÉDITIONS
```sql
CREATE TABLE schema_.expédition (
    id_expedition INTEGER PRIMARY KEY,
    client VARCHAR(200) NOT NULL,
    id_port_origin INTEGER NOT NULL,
    id_port_destination INTEGER NOT NULL,
    statut VARCHAR(50),
    date_creation DATE,
    FOREIGN KEY (id_port_origin) REFERENCES schema_.port(locode),
    FOREIGN KEY (id_port_destination) REFERENCES schema_.port(locode)
);
```

#### Table SEGMENTS
```sql
CREATE TABLE schema_.segment (
    id_segments INTEGER PRIMARY KEY,
    id_expedition INTEGER NOT NULL,
    imo INTEGER NOT NULL,
    date_depart DATE NOT NULL,
    arrivee_prévue TIMESTAMP,
    arrivee_reel TIMESTAMP,
    FOREIGN KEY (id_expedition) REFERENCES schema_.expédition(id_expedition),
    FOREIGN KEY (imo) REFERENCES schema_.navire(imo)
);
```

#### Table ÉVÉNEMENTS
```sql
CREATE TABLE schema_.evenement (
    id_evenement INTEGER PRIMARY KEY,
    type VARCHAR(50) NOT NULL,
    description TEXT
);
```

#### Table HISTORIQUES
```sql
CREATE TABLE schema_.historique (
    id_historique SERIAL PRIMARY KEY,
    iso INTEGER NOT NULL,
    ancien_statut VARCHAR(50),
    nouv_statut VARCHAR(50),
    date DATE,
    utilisateur VARCHAR(100),
    FOREIGN KEY (iso) REFERENCES schema_.conteneurs(iso)
);
```

---

## 🔒 Contraintes et Triggers PostgreSQL

### Contraintes d'Intégrité

#### 1. Contrainte sur l'Ordre des Escales
```sql
ALTER TABLE schema_.escale
ADD CONSTRAINT chk_escale_ordre
CHECK (ordre > 0);
```

**Objectif** : Garantir que l'ordre des escales est toujours strictement positif.

#### 2. Contrainte sur les Dates des Segments
```sql
ALTER TABLE schema_.segment
ADD CONSTRAINT ck_segment_dates
CHECK (arrivee_reel IS NULL OR arrivee_reel >= date_depart);
```

**Objectif** : S'assurer que la date d'arrivée réelle ne peut pas être antérieure à la date de départ.

#### 3. Contrainte sur les Statuts des Conteneurs
```sql
ALTER TABLE schema_.conteneurs
ADD CONSTRAINT ck_conteneur_statut
CHECK (statut IN ('au_port','en_transit','sur_navire','inspection'));
```

**Objectif** : Limiter les statuts possibles à des valeurs métier valides.

#### 4. Contrainte sur la Gravité des Événements
```sql
ALTER TABLE schema_.evenement_route
ADD CONSTRAINT ck_evenement_gravite
CHECK (gravité IN ('mineur','majeur','critique'));
```

**Objectif** : Standardiser les niveaux de gravité des événements.

### Triggers

#### 1. Trigger : Historisation des Conteneurs

**Fonction Trigger**
```sql
CREATE OR REPLACE FUNCTION schema_.fn_historique_conteneur()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.statut <> OLD.statut THEN
        INSERT INTO schema_.historique (
            iso,
            ancien_statut,
            nouv_statut,
            date,
            utilisateur
        )
        VALUES (
            OLD.iso,
            OLD.statut,
            NEW.statut,
            CURRENT_DATE,
            current_user
        );
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
```

**Déclencheur**
```sql
CREATE TRIGGER trg_historique_conteneur
AFTER UPDATE OF statut ON schema_.conteneurs
FOR EACH ROW
EXECUTE FUNCTION schema_.fn_historique_conteneur();
```

**Description** : Ce trigger enregistre automatiquement tout changement de statut d'un conteneur dans la table historique, avec la date et l'utilisateur ayant effectué la modification.

#### 2. Trigger : Protection des Événements

**Fonction Trigger**
```sql
CREATE OR REPLACE FUNCTION schema_.fn_interdire_modif_evenement()
RETURNS TRIGGER AS $$
BEGIN
    RAISE EXCEPTION 'Les événements ne peuvent pas être modifiés après création';
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
```

**Déclencheur**
```sql
CREATE TRIGGER trg_evenement_no_update
BEFORE UPDATE ON schema_.evenement
FOR EACH ROW
EXECUTE FUNCTION schema_.fn_interdire_modif_evenement();
```

**Description** : Ce trigger empêche toute modification des événements après leur création, garantissant ainsi l'immuabilité et la traçabilité des incidents.

---

## 🧪 Tests et Validation

### Plan de Tests

#### Test 1 : Création de Ports et Routes ✅

**Objectif** : Valider l'insertion de données de base
```sql
-- Insertion de ports
INSERT INTO schema_.port(locode, nom, localisation, categorie, capacite, active, pays)
VALUES 
(101, 'Port Casablanca', 'Casablanca', 'commercial', '100000', TRUE, 'Maroc'),
(102, 'Port Tanger', 'Tanger', 'commercial', '80000', TRUE, 'Maroc');

-- Insertion de route
INSERT INTO schema_.route(id_route, nom, frequence, active)
VALUES (201, 'Route Casablanca-Tanger', 'Hebdomadaire', TRUE);

-- Insertion d'escale
INSERT INTO schema_.escale(id_escal, locode, id_route, ordre, duree, distance)
VALUES (1, 101, 201, 1, '2 hours', 50);
```

**Résultat** : ✅ **SUCCÈS** - Données insérées correctement

---

#### Test 2 : Violation de Contrainte d'Ordre ❌

**Objectif** : Tester la contrainte `chk_escale_ordre`
```sql
INSERT INTO schema_.escale(id_escal, locode, id_route, ordre, duree, distance)
VALUES (2, 101, 201, 0, INTERVAL '1 hour', 150);
```

**Résultat** : ❌ **ERREUR ATTENDUE**
```
ERROR: new row for relation "escale" violates check constraint "chk_escale_ordre"
DETAIL: Failing row contains (2, 101, 201, 0, 01:00:00, 150.00).
```

---

#### Test 3 : Validation des Dates de Segment ✅

**Objectif** : Valider la contrainte `ck_segment_dates`
```sql
-- Préparation
INSERT INTO schema_.navire(imo, nom, armateur, capacite, type, etat)
VALUES (1234567, 'Navire Test', 'Armateur X', 5000, 'cargo', 'actif');

INSERT INTO schema_.expédition(id_expedition, client, id_port_origin, id_port_destination, statut, date_creation)
VALUES (1, 'Client Test', 101, 102, 'en_cours', CURRENT_DATE);

-- Test avec dates valides
INSERT INTO schema_.segment(id_segments, id_expedition, imo, date_depart, arrivee_prévue, arrivee_reel)
VALUES (1, 1, 1234567, '2025-12-18', '2025-12-19 10:00:00', '2025-12-19 12:00:00');
```

**Résultat** : ✅ **SUCCÈS** - Segment créé avec dates cohérentes

---

#### Test 4 : Dates Incohérentes ❌

**Objectif** : Tester le rejet de dates invalides
```sql
INSERT INTO schema_.segment(id_segments, id_expedition, imo, date_depart, arrivee_prévue, arrivee_reel)
VALUES (2, 1, 1234567, '2025-12-18', '2025-12-19 10:00:00', '2025-12-17 08:00:00');
```

**Résultat** : ❌ **ERREUR ATTENDUE**
```
ERROR: new row for relation "segment" violates check constraint "ck_segment_dates"
DETAIL: Failing row contains (2, 1, 1234567, 2025-12-18, 2025-12-19 10:00:00, 2025-12-17 08:00:00).
```

---

#### Test 5 : Statuts des Conteneurs ✅

**Objectif** : Valider la contrainte `ck_conteneur_statut`
```sql
-- Statut valide
INSERT INTO schema_.conteneurs(iso, type, statut, categorie, date_derni_inscreption, poids_max)
VALUES (1, '20ft', 'au_port', 'standard', CURRENT_DATE, 2000);
```

**Résultat** : ✅ **SUCCÈS**

---

#### Test 6 : Statut Invalide ❌
```sql
INSERT INTO schema_.conteneurs(iso, type, statut, categorie, date_derni_inscreption, poids_max)
VALUES (2, '40ft', 'invalide', 'standard', CURRENT_DATE, 4000);
```

**Résultat** : ❌ **ERREUR ATTENDUE**
```
ERROR: new row for relation "conteneurs" violates check constraint "ck_conteneur_statut"
```

---

#### Test 7 : Historisation Automatique ✅

**Objectif** : Vérifier le fonctionnement du trigger d'historisation
```sql
-- Mise à jour du statut
UPDATE schema_.conteneurs
SET statut = 'en_transit'
WHERE iso = 1;

-- Vérification de l'historique
SELECT * FROM schema_.historique WHERE iso = 1;
```

**Résultat** : ✅ **SUCCÈS**
```
id_historique | iso | ancien_statut | nouv_statut | date       | utilisateur
--------------+-----+---------------+-------------+------------+-------------
1            | 1   | au_port       | en_transit  | 2025-12-18 | postgres
```

---

#### Test 8 : Protection des Événements ❌

**Objectif** : Vérifier l'immuabilité des événements
```sql
-- Création d'un événement
INSERT INTO schema_.evenement(id_evenement, type, description)
VALUES (10, 'alerte', 'Test événement');

-- Tentative de modification
UPDATE schema_.evenement
SET description = 'Nouvelle description'
WHERE id_evenement = 10;
```

**Résultat** : ❌ **EXCEPTION ATTENDUE**
```
ERROR: Les événements ne peuvent pas être modifiés après création
CONTEXT: PL/pgSQL function fn_interdire_modif_evenement() line 3 at RAISE
```

---

#### Test 9 : Gravité des Événements ✅

**Objectif** : Valider la contrainte `ck_evenement_gravite`
```sql
-- Événement avec gravité valide
INSERT INTO schema_.evenement(id_evenement, type, description)
VALUES (1, 'alerte', 'Test événement route');

INSERT INTO schema_.evenement_route(id_evenement, id_route, date, gravité)
VALUES (1, 201, CURRENT_DATE, 'majeur');
```

**Résultat** : ✅ **SUCCÈS**

---

#### Test 10 : Gravité Invalide ❌
```sql
INSERT INTO schema_.evenement_route(id_evenement, id_route, date, gravité)
VALUES (2, 201, CURRENT_DATE, 'extrême');
```

**Résultat** : ❌ **ERREUR ATTENDUE**
```
ERROR: new row for relation "evenement_route" violates check constraint "ck_evenement_gravite"
```

---

### Résumé des Tests

| Test | Description | Statut | Objectif |
|------|-------------|--------|----------|
| Test 1 | Insertion de base | ✅ PASS | Validation données |
| Test 2 | Ordre négatif | ❌ FAIL (attendu) | Contrainte ordre |
| Test 3 | Dates valides | ✅ PASS | Cohérence dates |
| Test 4 | Dates invalides | ❌ FAIL (attendu) | Contrainte dates |
| Test 5 | Statut valide | ✅ PASS | Validation statut |
| Test 6 | Statut invalide | ❌ FAIL (attendu) | Contrainte statut |
| Test 7 | Historisation | ✅ PASS | Trigger historique |
| Test 8 | Modification événement | ❌ FAIL (attendu) | Trigger protection |
| Test 9 | Gravité valide | ✅ PASS | Validation gravité |
| Test 10 | Gravité invalide | ❌ FAIL (attendu) | Contrainte gravité |

**Taux de réussite** : 100% (tous les tests se comportent comme attendu)

---

## 🛠️ Technologies Utilisées

### Base de Données
- **PostgreSQL 12+**
  - Système de gestion de base de données relationnel
  - Support avancé des contraintes et triggers
  - Performance et fiabilité éprouvées

### Langages
- **SQL (ANSI)**
  - Langage de définition de données (DDL)
  - Langage de manipulation de données (DML)
  
- **PL/pgSQL**
  - Langage procédural pour triggers et fonctions
  - Gestion avancée des événements

### Outils de Modélisation
- **Draw.io / Lucidchart**
  - Création des diagrammes MCD/MLD
  - Modélisation visuelle

### Gestion de Projet
- **Trello**
  - Suivi des tâches
  - Organisation agile
  
- **Git / GitHub**
  - Versioning du code
  - Collaboration


## 📊 Conclusion

Ce projet de système de gestion portuaire et maritime représente une solution complète et robuste pour la gestion des opérations portuaires. 
