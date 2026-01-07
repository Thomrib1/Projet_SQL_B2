CREATE OR REPLACE FUNCTION supprimer_paiement_refuse()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.statut_paiement = 'Paiement refusé' THEN
        DELETE FROM paiements WHERE id_paiement = NEW.id_paiement;
        RETURN NULL;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_suppr_paiement_errone
AFTER INSERT OR UPDATE ON paiements
FOR EACH ROW
EXECUTE FUNCTION supprimer_paiement_refuse();