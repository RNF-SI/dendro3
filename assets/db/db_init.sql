------------------------
------- TABLES ---------
------------------------

-- Table contenant les différentes essences
CREATE TABLE bib_essences (
  code_essence character varying(4) NOT NULL PRIMARY KEY,
  cd_nom integer,
  nom character varying,
  nom_latin character varying,
  ess_reg character varying(4),
  couleur character varying(25)
);

-- Table des dispositifs
CREATE TABLE t_dispositifs (
  id_dispositif serial NOT NULL PRIMARY KEY,
  name character varying NOT NULL,
  id_organisme integer,
  alluvial boolean NOT NULL DEFAULT false
);

CREATE TABLE t_placettes (
  id_placette serial NOT NULL PRIMARY KEY,
  id_dispositif integer NOT NULL,
  id_placette_orig character varying(10),
  strate integer,
  pente real,
  poids_placette real,
  correction_pente boolean,
  exposition integer,
  profondeur_app character varying,
  profondeur_hydr real,
  texture character varying,
  habitat character varying,
  station character varying,
  typologie character varying,
  groupe character varying,
  groupe1 character varying,
  groupe2 character varying,
  ref_habitat character varying,
  precision_habitat text,
  ref_station character varying,
  ref_typologie character varying,
  descriptif_groupe text,
  descriptif_groupe1 text,
  descriptif_groupe2 text,
  precision_gps character varying,
  cheminement text,
  CONSTRAINT fk_t_placettes_t_dispositifs
    FOREIGN KEY (id_dispositif) REFERENCES t_dispositifs (id_dispositif)
    ON UPDATE CASCADE
    ON DELETE CASCADE
  -- geom geometry(POINT, 2154),
  -- geom_wgs84 geometry(POINT, 4326)
);

CREATE TABLE t_reperes (
  id_repere TEXT NOT NULL PRIMARY KEY,
  id_placette integer NOT NULL,
  azimut real,
  distance real,
  diametre real,
  repere character varying,
  observation text,
  created_at TEXT DEFAULT (strftime('%Y-%m-%d %H:%M:%f', 'now')),
  created_on character varying,
  created_by character varying,
  updated_at TEXT DEFAULT (strftime('%Y-%m-%d %H:%M:%f', 'now')),
  updated_on character varying,
  updated_by character varying,
  deleted BOOLEAN DEFAULT 0,
  CONSTRAINT fk_t_reperes_t_placettes
    FOREIGN KEY (id_placette) REFERENCES t_placettes (id_placette)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);


CREATE TABLE t_cycles (
  id_cycle serial NOT NULL PRIMARY KEY,
  id_dispositif integer NOT NULL,
  num_cycle integer NOT NULL,
  coeff integer,
  date_debut date,
  date_fin date,
  diam_lim real,
  monitor character varying (50),
  CONSTRAINT fk_t_cycles_t_placettes
    FOREIGN KEY (id_dispositif) REFERENCES t_dispositifs (id_dispositif)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE INDEX idx_t_cycles_num_cycle on t_cycles (num_cycle);

CREATE TABLE t_arbres (
  id_arbre TEXT NOT NULL PRIMARY KEY,
  id_arbre_orig integer,
  id_placette integer NOT NULL,
  code_essence character varying(4),
  azimut real,
  distance real,
  taillis boolean,
  observation text,
  created_at TEXT DEFAULT (strftime('%Y-%m-%d %H:%M:%f', 'now')),
  created_on character varying,
  created_by character varying,
  updated_at TEXT DEFAULT (strftime('%Y-%m-%d %H:%M:%f', 'now')),
  updated_on character varying,
  updated_by character varying,
  deleted BOOLEAN DEFAULT 0,
  CONSTRAINT fk_t_arbres_t_placettes
    FOREIGN KEY (id_placette) REFERENCES t_placettes (id_placette)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  CONSTRAINT fk_t_arbres_bib_essences
    FOREIGN KEY (code_essence) REFERENCES bib_essences (code_essence)
    ON UPDATE CASCADE
);

CREATE TABLE t_arbres_mesures (
  id_arbre_mesure TEXT NOT NULL PRIMARY KEY,
  id_arbre integer NOT NULL,
  id_cycle integer NOT NULL,
  diametre1 real,
  diametre2 real,
  type character varying(2),
  hauteur_totale real,
  hauteur_branche real,
  stade_durete integer,
  stade_ecorce integer,
  liane character varying(25),
  diametre_liane real,
  coupe char(1),
  limite boolean,
  id_nomenclature_code_sanitaire integer,
  code_ecolo character varying,
  ref_code_ecolo character varying,
  ratio_hauteur boolean,
  observation text,
  created_at TEXT DEFAULT (strftime('%Y-%m-%d %H:%M:%f', 'now')),
  created_on character varying,
  created_by character varying,
  updated_at TEXT DEFAULT (strftime('%Y-%m-%d %H:%M:%f', 'now')),
  updated_on character varying,
  updated_by character varying,
  deleted BOOLEAN DEFAULT 0,
  CONSTRAINT fk_t_arbres_mesures_t_arbres
    FOREIGN KEY (id_arbre) REFERENCES t_arbres (id_arbre)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  CONSTRAINT fk_t_arbres_mesures_t_cycles
    FOREIGN KEY (id_cycle) REFERENCES t_cycles (id_cycle)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);


CREATE INDEX idx_t_arbres_mesures_id_cycle on t_arbres_mesures (id_cycle);

CREATE TABLE t_regenerations (
  id_regeneration TEXT NOT NULL PRIMARY KEY,
  id_cycle_placette integer,
  sous_placette integer,
  code_essence character varying(4),
  recouvrement real,
  classe1 integer,
  classe2 integer,
  classe3 integer,
  taillis boolean,
  abroutissement boolean,
  id_nomenclature_abroutissement integer,
  observation text,
  created_at TEXT DEFAULT (strftime('%Y-%m-%d %H:%M:%f', 'now')),
  created_on character varying,
  created_by character varying,
  updated_at TEXT DEFAULT (strftime('%Y-%m-%d %H:%M:%f', 'now')),
  updated_on character varying,
  updated_by character varying,
  deleted BOOLEAN DEFAULT 0,
  CONSTRAINT fk_t_regenerations_cor_cycles_placettes
    FOREIGN KEY (id_cycle_placette) REFERENCES cor_cycles_placettes (id_cycle_placette)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

-- Table contenant les limites des catégories de BM selon les dispositifs
CREATE TABLE t_categories (
	id_category serial NOT NULL PRIMARY KEY,
	id_dispositif integer NOT NULL,
	pb real,
	bm real,
	gb real,
	tgb real,
  CONSTRAINT fk_t_categories_t_dispositifs
    FOREIGN KEY (id_dispositif) REFERENCES t_dispositifs (id_dispositif)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE TABLE t_bm_sup_30 (
  id_bm_sup_30 TEXT NOT NULL PRIMARY KEY,
  id_bm_sup_30_orig integer,
  id_placette integer NOT NULL,
  id_arbre integer,
  code_essence character varying(4),
  azimut real,
  distance real,
  orientation real,
  azimut_souche real,
  distance_souche real,
  observation text,
  created_at TEXT DEFAULT (strftime('%Y-%m-%d %H:%M:%f', 'now')),
  created_on character varying,
  created_by character varying,
  updated_at TEXT DEFAULT (strftime('%Y-%m-%d %H:%M:%f', 'now')),
  updated_on character varying,
  updated_by character varying,
  deleted BOOLEAN DEFAULT 0,
  CONSTRAINT fk_t_bm_sup_30_t_placettes
    FOREIGN KEY (id_placette) REFERENCES t_placettes (id_placette)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  CONSTRAINT fk_t_bm_sup_30_bib_essences
    FOREIGN KEY (code_essence) REFERENCES bib_essences (code_essence)
    ON UPDATE CASCADE
);

CREATE TABLE t_bm_sup_30_mesures (
  id_bm_sup_30_mesure TEXT NOT NULL PRIMARY KEY,
  id_bm_sup_30 integer NOT NULL,
  id_cycle integer NOT NULL,
  diametre_ini real,
  diametre_med real,
  diametre_fin real,
  diametre_130 real,
  longueur real,
  ratio_hauteur boolean,
  contact real,
  chablis boolean,
  stade_durete integer,
  stade_ecorce integer,
  observation text,
  created_at TEXT DEFAULT (strftime('%Y-%m-%d %H:%M:%f', 'now')),
  created_on character varying,
  created_by character varying,
  updated_at TEXT DEFAULT (strftime('%Y-%m-%d %H:%M:%f', 'now')),
  updated_on character varying,
  updated_by character varying,
  deleted BOOLEAN DEFAULT 0,
  CONSTRAINT fk_t_bm_sup_30_mesures_t_bm_sup_30
    FOREIGN KEY (id_bm_sup_30) REFERENCES t_bm_sup_30 (id_bm_sup_30)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  CONSTRAINT fk_t_bm_sup_30_mesures_t_cycles
    FOREIGN KEY (id_cycle) REFERENCES t_cycles (id_cycle)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);
-- Table des transects : une ligne par bois mort
CREATE TABLE t_transects (
  id_transect TEXT NOT NULL PRIMARY KEY,
  id_cycle_placette integer NOT NULL,
  id_transect_orig integer,
  code_essence character varying(4),
  ref_transect character varying(2),
  distance real,
  orientation real,
  azimut_souche real,
  distance_souche real,
  diametre real,
  diametre_130 real,
  ratio_hauteur boolean,
  contact boolean,
  angle real,
  chablis boolean,
  stade_durete integer,
  stade_ecorce integer,
  observation text,
  created_at TEXT DEFAULT (strftime('%Y-%m-%d %H:%M:%f', 'now')),
  created_on character varying,
  created_by character varying,
  updated_at TEXT DEFAULT (strftime('%Y-%m-%d %H:%M:%f', 'now')),
  updated_on character varying,
  updated_by character varying,
  deleted BOOLEAN DEFAULT 0,
  CONSTRAINT fk_t_transects_cor_cycles_placettes
    FOREIGN KEY (id_cycle_placette) REFERENCES cor_cycles_placettes (id_cycle_placette)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE TABLE t_tarifs (
  id_tarif serial not null PRIMARY KEY,
  id_dispositif integer NOT NULL,
  code_essence  character varying(4) NOT NULL,
  type_tarif character varying(10),
  num_tarif  real,
  CONSTRAINT fk_t_tarifs_t_dispositifs
    FOREIGN KEY (id_dispositif) REFERENCES t_dispositifs (id_dispositif)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  CONSTRAINT fk_t_tarifs_bib_essences
    FOREIGN KEY (code_essence) REFERENCES bib_essences (code_essence)
    ON UPDATE CASCADE
);

CREATE TABLE t_regroupements_essences (
  id_dispositif integer NOT NULL,
  code_essence  character varying(4) NOT NULL,
  code_regroupement character varying(10),
  couleur  character varying(25),
  PRIMARY KEY(id_dispositif,code_essence),
  CONSTRAINT fk_t_reg_essences_bib_essences
    FOREIGN KEY (code_essence) REFERENCES bib_essences (code_essence)
    ON UPDATE CASCADE,
  CONSTRAINT fk_t_reg_essences_t_dispositifs
    FOREIGN KEY (id_dispositif) REFERENCES t_dispositifs (id_dispositif)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE TABLE cor_cycles_placettes (
    id_cycle_placette TEXT NOT NULL PRIMARY KEY,
    id_cycle integer NOT NULL,
    id_placette integer NOT NULL,
    date_releve date,
    date_intervention character varying,
    annee integer,
    nature_intervention character varying,
    gestion_placette character varying,
    id_nomenclature_castor integer,
    id_nomenclature_frottis integer,
    id_nomenclature_boutis integer,
    recouv_herbes_basses real,
    recouv_herbes_hautes real,
    recouv_buissons real,
    recouv_arbres real,
    created_at TEXT DEFAULT (strftime('%Y-%m-%d %H:%M:%f', 'now')),
    created_on character varying,
    created_by character varying,
    updated_at TEXT DEFAULT (strftime('%Y-%m-%d %H:%M:%f', 'now')),
    updated_on character varying,
    updated_by character varying,
    deleted BOOLEAN DEFAULT 0,
    CONSTRAINT fk_cor_cycles_placettes_t_cycles
      FOREIGN KEY (id_cycle) REFERENCES t_cycles (id_cycle)
      ON UPDATE CASCADE
      ON DELETE CASCADE,
    CONSTRAINT fk_cor_cycles_placettes_t_placettes
      FOREIGN KEY (id_placette) REFERENCES t_placettes (id_placette)
      ON UPDATE CASCADE
      ON DELETE CASCADE
);

CREATE INDEX idx_cor_cycles_placettes_id_cycle on cor_cycles_placettes (id_cycle);

CREATE TABLE cor_dispositif_area (
  id_dispositif integer NOT NULL,
  id_area integer NOT NULL,
  "order" integer,
  PRIMARY KEY (id_dispositif, id_area),
  CONSTRAINT fk_cor_dispositifs_area_t_dispositifs
    FOREIGN KEY (id_dispositif) REFERENCES t_dispositifs (id_dispositif)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE TABLE cor_dispositif_municipality (
  id_dispositif integer NOT NULL,
  id_municipality character varying(25) NOT NULL,
  PRIMARY KEY (id_dispositif, id_municipality),
  CONSTRAINT fk_cor_dispositifs_municipality_t_dispositifs
    FOREIGN KEY (id_dispositif) REFERENCES t_dispositifs (id_dispositif)
    ON UPDATE CASCADE
    ON DELETE CASCADE


);

-- Lien vers la table roles (utilisateurs)
CREATE TABLE cor_cycles_roles (
  id_cycle integer NOT NULL,
  id_role integer NOT NULL,
  PRIMARY KEY (id_cycle, id_role),
  CONSTRAINT fk_cor_cycles_roles_t_dispositifs
    FOREIGN KEY (id_cycle) REFERENCES t_cycles (id_cycle)
    ON UPDATE CASCADE
    ON DELETE CASCADE

);

-- Lien vers la table roles (utilisateurs)
CREATE TABLE cor_dispositifs_roles (
  id_dispositif integer NOT NULL,
  id_role integer NOT NULL,
  PRIMARY KEY (id_dispositif, id_role),
  CONSTRAINT fk_cor_dispositifs_roles_t_dispositifs
    FOREIGN KEY (id_dispositif) REFERENCES t_dispositifs (id_dispositif)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

-- Create table des nomenclatures du PSDRF
CREATE TABLE t_nomenclatures (
  id_nomenclature integer NOT NULL PRIMARY KEY,
  id_type integer NOT NULL,
  cd_nomenclature text NOT NULL,
  mnemonique text,
  label_default text NOT NULL,
  definition_default text,
  label_fr text NOT NULL,
  definition_fr text,
  label_en text,
  definition_en text,
  label_es text,
  definition_es text,
  label_de text,
  definition_de text,
  label_it text,
  definition_it text,
  source text,
  statut character varying(20),
  id_broader integer,
  hierarchy text,
  active boolean NOT NULL DEFAULT true,
  CONSTRAINT unique_id_type_cd_nomenclature UNIQUE (id_type, cd_nomenclature),
  CONSTRAINT fk_t_nomenclatures_id_broader FOREIGN KEY (id_broader)
      REFERENCES t_nomenclatures (id_nomenclature) MATCH SIMPLE
      ON UPDATE NO ACTION
      ON DELETE NO ACTION,
  CONSTRAINT fk_t_nomenclatures_id_type FOREIGN KEY (id_type)
      REFERENCES bib_nomenclatures_types (id_type) MATCH SIMPLE
      ON UPDATE CASCADE
      ON DELETE NO ACTION
);

-- Create table des nomenclatures du PSDRF
CREATE TABLE bib_nomenclatures_types(
    id_type integer NOT NULL,
    mnemonique character varying(255),
    label_default character varying(255) NOT NULL,
    definition_default text,
    label_fr character varying(255) NOT NULL,
    definition_fr text,
    label_en character varying(255),
    definition_en text,
    label_es character varying(255),
    definition_es text,
    label_de character varying(255),
    definition_de text,
    label_it character varying(255),
    definition_it text,
    source character varying(50),
    statut character varying(20),
    CONSTRAINT pk_bib_nomenclatures_types PRIMARY KEY (id_type),
    CONSTRAINT unique_bib_nomenclatures_types_mnemonique UNIQUE (mnemonique)
);
