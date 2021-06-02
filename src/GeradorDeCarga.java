import java.util.concurrent.atomic.AtomicBoolean;

import org.apache.commons.math3.distribution.ExponentialDistribution;

public class GeradorDeCarga implements Runnable {

	private ExponentialDistribution distribuicaoTempoDeServico;
	private ExponentialDistribution distribuicaoTempoEntreChegadas;
	private FilaDeRequisicoes filaDeRequisicoes;
	private volatile AtomicBoolean medindo;

	public GeradorDeCarga(double taxaDeChegadaMedia, double tempoDeServicoMedio,
			FilaDeRequisicoes filaDeRequisicoes, AtomicBoolean medindo) {
		this.filaDeRequisicoes = filaDeRequisicoes;
		this.medindo = medindo;
		this.distribuicaoTempoEntreChegadas = new ExponentialDistribution(
				1.0 / taxaDeChegadaMedia);
		this.distribuicaoTempoDeServico = new ExponentialDistribution(
				tempoDeServicoMedio);
	}

	@Override
	public void run() {
		try {
			while (medindo.get()) {
				double tempoDeServico = distribuicaoTempoDeServico.sample();
				double espera = distribuicaoTempoEntreChegadas.sample();
				Thread.sleep(Math.round(espera * 1000));
				filaDeRequisicoes.adicionaRequisicao(new Requisicao(tempoDeServico));
			}
		} catch (InterruptedException e) {
		}
	}
}
