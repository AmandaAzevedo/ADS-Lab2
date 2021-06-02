import java.util.concurrent.atomic.AtomicBoolean;

public class ProcessadorDeRequisicoes implements Runnable {

	private FilaDeRequisicoes filaDeRequisicoes;
	private volatile AtomicBoolean medindo;

	public ProcessadorDeRequisicoes(FilaDeRequisicoes filaDeRequisicoes, AtomicBoolean medindo) {
		this.filaDeRequisicoes = filaDeRequisicoes;
		this.medindo = medindo;
	}

	@Override
	public void run() {
		try {
			while (medindo.get()) {
				Requisicao requisicao = filaDeRequisicoes.retiraRequisicao();
				long tempoInicial = System.currentTimeMillis();
				long tempoDeServico = Math.round(requisicao.getTempoDeServico() * 1000);
				while (System.currentTimeMillis() < tempoInicial + tempoDeServico);
				
			}
		} catch (InterruptedException e) { }
	}
}
