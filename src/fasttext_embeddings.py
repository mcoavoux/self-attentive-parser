import numpy
import torch

def load_vectors(fname):
    fin = open(fname, 'r', encoding='utf-8', newline='\n', errors='ignore')
    n, d = map(int, fin.readline().split())
    data = {}
    for line in fin:
        tokens = line.rstrip().split(' ')
        vec = list(map(float, tokens[1:]))
        data[tokens[0]] = vec
        assert(len(vec) == d)
    print(f"Loaded {n} vectors from fasttext")
    return data, d


def assign_pretrained(filename, vocab, embedding):
    vectors, d = load_vectors(filename)
    num_modified = 0
    device = embedding.weight.data.device
    for i, word in enumerate(vocab.values):
        assert(vocab.indices[word] == i)
        if word in vectors:
            embedding.weight.data[i, :d] = torch.tensor(vectors[word], requires_grad=False).to(device)
            num_modified += 1
    print(f"Loaded fasttext embeddings for {num_modified} words (over {vocab.size})")

if __name__ == "__main__":

    vectors = load_vectors("../../cc.fr.300.vec")

    print(len(vectors))
    print(list(vectors)[:30])
    print(len(vectors["le"]))

