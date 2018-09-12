package vue;
import javafx.application.Application;
import javafx.scene.Scene;
import javafx.scene.layout.GridPane;
import javafx.scene.layout.Pane;
import javafx.stage.Stage;
import modele.Equipe;
import javafx.scene.control.Label;

public class VueEquipe extends Scene {

	protected Label valeurNom;
	protected Label valeurAnneeDeCreation;
	protected Label valeurRegion;
	
	public VueEquipe() {
		super(new GridPane(), 400,400);
		GridPane grilleEquipe = (GridPane) this.getRoot();
		
		valeurNom = new Label("Fnatic");
		grilleEquipe.add(new Label("Nom : "), 0, 0);
		grilleEquipe.add(valeurNom, 1, 0);
		
		valeurAnneeDeCreation = new Label("2011");
		grilleEquipe.add(new Label("Création : "), 0, 1);
		grilleEquipe.add(valeurAnneeDeCreation, 1, 1);
		
		valeurRegion = new Label("Europe");
		grilleEquipe.add(new Label("Région : "), 0, 2);
		grilleEquipe.add(valeurRegion, 1, 2);
	}
	
	public void afficherEquipe(Equipe equipe) {
		this.valeurAnneeDeCreation.setText(equipe.getAnneeDeCreation());
		this.valeurNom.setText(equipe.getNom());
		this.valeurRegion.setText(equipe.getRegion());
	}
}