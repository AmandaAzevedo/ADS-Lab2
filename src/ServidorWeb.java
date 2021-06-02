import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicBoolean;

public class ServidorWeb {

	public static double DEFAULT_TEMPO_OBSERVACAO = 30; // segundos
	public static int DEFAULT_NUM_SERVIDORES = 1;
	public static double DEFAULT_TAXA_CHEGADA_MEDIA = 1; // requisicoes por segundo
	public static double DEFAULT_TEMPO_SERVICO_MEDIO = 1; // segundos

	public static void main(String[] args) throws InterruptedException {

		if (args.length == 0) {
			System.err.println("Parametros incorretos. Uso:");
			System.err.println("java ServidorWeb <taxa-de-chegada-media> <tempo-de-servico-medio> <num-servidores> <tempo-observacao>");
			System.exit(1);
		}
		
		double taxaDeChegadaMedia = args.length > 0 ? Double
				.parseDouble(args[0]) : DEFAULT_TAXA_CHEGADA_MEDIA;
		double tempoDeServicoMedio = args.length > 1 ? Double
				.parseDouble(args[1]) : DEFAULT_TEMPO_SERVICO_MEDIO;
		int numServidores = args.length > 2 ? Integer.parseInt(args[2])
				: DEFAULT_NUM_SERVIDORES;
		double tempoDeObservacao = args.length > 3 ? Double
				.parseDouble(args[3]) : DEFAULT_TEMPO_OBSERVACAO;

		AtomicBoolean emMedicao = new AtomicBoolean(true);
		FilaDeRequisicoes filaDeRequisicoes = new FilaDeRequisicoes();

		GeradorDeCarga geradorDeCarga = new GeradorDeCarga(taxaDeChegadaMedia,
				tempoDeServicoMedio, filaDeRequisicoes, emMedicao);

		ExecutorService threadPool = Executors
				.newFixedThreadPool(numServidores + 1);
		for (int i = 0; i < numServidores; i++) {
			threadPool.execute(new ProcessadorDeRequisicoes(filaDeRequisicoes,
					emMedicao));
		}
		threadPool.execute(geradorDeCarga);

		Thread.sleep(Math.round(tempoDeObservacao * 1000));

		emMedicao.set(false);
		threadPool.shutdownNow();

		System.out
				.println("TaxaDeChegadaMedia TempoDeServicoMedio NumServidores RequisicoesSubmetidas RequisicoesConcluidas TempoMedioDeResposta TamanhoMedioDaFila");
		System.out.format("%f %f %d %d %d %f %f\n", taxaDeChegadaMedia,
				tempoDeServicoMedio, numServidores, filaDeRequisicoes
						.getAdicionadas().get(), filaDeRequisicoes
						.getRetiradas().get(), filaDeRequisicoes
						.getTempoDeRespostaStats().getMean(), filaDeRequisicoes
						.getTamanhoDaFilaStats().getMean());
	}
}