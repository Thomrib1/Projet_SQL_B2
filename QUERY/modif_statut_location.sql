CREATE OR REPLACE FUNCTION update_location_status()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.heure_fin < CURRENT_TIMESTAMP THEN
        NEW.statut_location := 'Terminée';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_check_statut_location
BEFORE INSERT OR UPDATE ON LOCATIONS
FOR EACH ROW
EXECUTE FUNCTION update_location_status();