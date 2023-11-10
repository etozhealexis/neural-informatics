import numpy as np


class RosenblattPerceptron:
    def __init__(self, numNeurons=1):
        self.weights = None
        self.biases = None
        self.numNeurons = numNeurons

    def train(self, P, T, epochs=50, showCoeffs=False):
        numFeatures = P.shape[1]
        self.weights = np.random.uniform(-1, 1, [self.numNeurons, numFeatures])
        self.biases = np.random.uniform(-1, 1, self.numNeurons)

        for epoch in range(epochs):
            for i, p in enumerate(P):
                a = self.predict(p)
                error = T[i] - a
                transposedError = np.atleast_2d(error).T
                reshapedP = np.atleast_2d(p)
                newWeight = transposedError.dot(reshapedP)

                self.weights += newWeight
                self.biases += error

            if (showCoeffs):
                print(f"Эпоха №{epoch + 1}")
                print("Весовые коэффициенты:\n", self.weights)
                print("Коэффициенты смещения:\n", self.biases)

    def predict(self, p):
        sum = self.weights.dot(p) + self.biases
        return self.hardlim(sum)

    def test(self, pInput, tInput):
        for p, t in zip(pInput, tInput):
            output = self.predict(p)
            print(f"{p}=>{output} (expected {t})")

    def testRandom(self, num_randoms):
        random_p = np.random.uniform(-5.0, 5.0, (num_randoms, 2))
        random_t = []
        for i in range(num_randoms):
            random_t.append(self.predict(random_p[i]))
        return random_p, random_t

    def hardlim(self, x):
        return np.where(x > 0, 1, 0)
