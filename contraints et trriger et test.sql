--l'order est stricte
ALTER TABLE schema_.escale
ADD CONSTRAINT chk_escale_ordre
CHECK (ordre > 0);
---test:
INSERT INTO schema_.port(locode, nom, localisation, categorie, capacite, active, pays)
VALUES 
(101, 'Port Casablanca', 'Casablanca', 'commercial', '100000', TRUE, 'Maroc'),
(102, 'Port Tanger', 'Tanger', 'commercial', '80000', TRUE, 'Maroc');

INSERT INTO schema_.route(id_route, nom, frequence, active)
VALUES (201, 'Route Casablanca-Tanger', 'Hebdomadaire', TRUE);


INSERT INTO schema_.escale(id_escal, locode, id_route, ordre, duree, distance)
VALUES (1, 101, 201, 1, '2 hours', 50);
----test2 avec erreur:
INSERT INTO schema_.escale(id_escal, locode, id_route, ordre, duree, distance)
VALUES (2, 101, 201, 0, INTERVAL '1 hour', 150);

--date arriver >= date depart
ALTER TABLE schema_.segment
ADD CONSTRAINT ck_segment_dates
CHECK (arrivee_reel IS NULL OR arrivee_reel >= date_depart);
--test1
INSERT INTO schema_.navire(imo, nom, armateur, capacite, type, etat)
VALUES (1234567, 'Navire Test', 'Armateur X', 5000, 'cargo', 'actif');
INSERT INTO schema_.expédition(
    id_expedition, client, id_port_origin, id_port_destination, statut, date_creation
) VALUES (
    1, 'Client Test', 101, 102, 'en_cours', CURRENT_DATE
);


INSERT INTO schema_.segment(id_segments, id_expedition, imo, date_depart, arrivee_prévue, arrivee_reel)
VALUES (1, 1, 1234567, '2025-12-18', '2025-12-19 10:00:00', '2025-12-19 12:00:00');

--test avec erreur:
INSERT INTO schema_.segment(id_segments, id_expedition, imo, date_depart, arrivee_prévue, arrivee_reel)
VALUES (2, 1, 1234567, '2025-12-18', '2025-12-19 10:00:00', '2025-12-17 08:00:00');

--check de status
ALTER TABLE schema_.conteneurs
ADD CONSTRAINT ck_conteneur_statut
CHECK (statut IN ('au_port','en_transit','sur_navire','inspection'));
--test:
INSERT INTO schema_.conteneurs(iso, type, statut, categorie, date_derni_inscreption, poids_max)
VALUES (1, '20ft', 'au_port', 'standard', CURRENT_DATE, 2000);
--test invalide:
INSERT INTO schema_.conteneurs(iso, type, statut, categorie, date_derni_inscreption, poids_max)
VALUES (2, '40ft', 'invalide', 'standard', CURRENT_DATE, 4000);

--check de gravité
ALTER TABLE schema_.evenement_route
ADD CONSTRAINT ck_evenement_gravite
CHECK ("gravité" IN ('mineur','majeur','critique'));
--test:
INSERT INTO schema_.evenement(id_evenement, type, description)
VALUES (1, 'alerte', 'Test événement route');

INSERT INTO schema_.evenement_route(id_evenement, id_route, date, gravité)
VALUES (1, 201, CURRENT_DATE, 'majeur');

--test invalid:
INSERT INTO schema_.evenement_route(id_evenement, id_route, date, gravité)
VALUES (2, 201, CURRENT_DATE, 'extrême');




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



DROP TRIGGER IF EXISTS trg_historique_conteneur ON schema_.conteneurs;

CREATE TRIGGER trg_historique_conteneur
AFTER UPDATE OF statut ON schema_.conteneurs
FOR EACH ROW
EXECUTE FUNCTION schema_.fn_historique_conteneur();

---test update le conteneur:
UPDATE schema_.conteneurs
SET statut = 'en_transit'
WHERE iso = 1;

set search_path to schema_
select*from schema_.historique
select*from schema_.conteneurs
CREATE OR REPLACE FUNCTION schema_.fn_interdire_modif_evenement()
RETURNS TRIGGER AS $$
BEGIN
    
    RAISE EXCEPTION 'Les événements ne peuvent pas être modifiés après création';
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trg_evenement_no_update
BEFORE UPDATE ON schema_.evenement
FOR EACH ROW
EXECUTE FUNCTION schema_.fn_interdire_modif_evenement();

INSERT INTO schema_.evenement(id_evenement, type, description)
VALUES (10, 'alerte', 'Test événement');

UPDATE schema_.evenement
SET description = 'Nouvelle description'
WHERE id_evenement = 10;

