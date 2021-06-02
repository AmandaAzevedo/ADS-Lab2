
public class Requisicao {
	
	private double tempoDeServico;
	private long tempoDeChegada;

	public Requisicao(double tempoDeServico) {
		this.tempoDeServico = tempoDeServico;
	}
	
	public double getTempoDeServico() {
		return tempoDeServico;
	}
	
	public void setTempoDeChegada(long tempoDeChegada) {
		this.tempoDeChegada = tempoDeChegada;
	}
	
	public long getTempoDeChegada() {
		return tempoDeChegada;
	}
}
