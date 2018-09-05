package vue;
import javafx.application.Application;
import javafx.scene.Scene;
import javafx.scene.layout.GridPane;
import javafx.scene.layout.Pane;
import javafx.stage.Stage;
import javafx.scene.control.Label;

public class VueEquipe extends Application {

	@Override
	public void start(Stage stade) throws Exception {
		Pane panneau = new Pane();
		GridPane grilleEquipe = new GridPane();
		
		Label valeurNom = new Label("Fnatic");
		grilleEquipe.add(new Label("Nom : "), 0, 0);
		grilleEquipe.add(valeurNom, 1, 0);
		
		Label valeurAnneeDeCreation = new Label("2011");
		grilleEquipe.add(new Label("Création : "), 0, 1);
		grilleEquipe.add(valeurAnneeDeCreation, 1, 1);
		
		Label valeurRegion = new Label("Europe");
		grilleEquipe.add(new Label("Région : "), 0, 2);
		grilleEquipe.add(valeurRegion, 1, 2);
		
		panneau.getChildren().add(grilleEquipe);
		
 		stade.setScene(new Scene(panneau, 400, 400));
		stade.show();
	}

}
