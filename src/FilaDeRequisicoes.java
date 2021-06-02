import java.util.concurrent.BlockingQueue;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.atomic.AtomicLong;

import org.apache.commons.math3.stat.descriptive.SummaryStatistics;

public class FilaDeRequisicoes {

	private BlockingQueue<Requisicao> fila;
	private SummaryStatistics tempoDeRespostaStats;
	private SummaryStatistics tamanhoDaFilaStats;
	private SummaryStatistics utilizacaoStats;
	private AtomicInteger adicionadas;
	private AtomicInteger retiradas;

	public FilaDeRequisicoes() {
		this.fila = new LinkedBlockingQueue<Requisicao>();
		this.adicionadas = new AtomicInteger();
		this.retiradas = new AtomicInteger();
		this.tempoDeRespostaStats = new SummaryStatistics();
		this.tamanhoDaFilaStats = new SummaryStatistics();
		this.utilizacaoStats = new SummaryStatistics();
	}

	public void adicionaRequisicao(Requisicao requisicao) {
		requisicao.setTempoDeChegada(System.currentTimeMillis());
		adicionadas.incrementAndGet();
		fila.add(requisicao);
	}

	public Requisicao retiraRequisicao() throws InterruptedException {
		tamanhoDaFilaStats.addValue(fila.size());
		Requisicao requisicao = fila.take();
		retiradas.incrementAndGet();
		double tempoDeEspera = (System.currentTimeMillis() - requisicao
				.getTempoDeChegada()) / 1000;
		double tempoDeResposta = tempoDeEspera + requisicao.getTempoDeServico();
		tempoDeRespostaStats.addValue(tempoDeResposta);
		return requisicao;
	}

	public AtomicInteger getAdicionadas() {
		return adicionadas;
	}

	public AtomicInteger getRetiradas() {
		return retiradas;
	}

	public SummaryStatistics getTempoDeRespostaStats() {
		return tempoDeRespostaStats;
	}

	public SummaryStatistics getTamanhoDaFilaStats() {
		return tamanhoDaFilaStats;
	}

	public SummaryStatistics getUtilizacaoStats() {
		return utilizacaoStats;
	}
}
