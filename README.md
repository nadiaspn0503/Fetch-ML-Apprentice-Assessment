# Fetch-ML-Apprentice-Assessment
This repo contains the files for the Fetch ML Apprentice Assessment

## Task 1: Sentence Transformer Implementation
Mean pooling was used to encode input sentences into fixed-length embeddings. This is because mean pooling is simple yet effective. It works well for NLP as it reduces dimensionality and prevents overfitting. To keep things simple, no extra layers were added.

## Task 2: Multi-Task Learning Expansion
The shared BERT encoder allows me to complete both tasks without recreating the same model. It also allows me to be able to add more tasks later if need be. 

In Task A I created a fully connected linear layer that uses the BERT vector to output the probability score for predefined sentence classes. These classes include personal statements, general facts, and app-related sentences.

In Task B I used the same BERT vector and created another fully connected linear layer that outputs the probability score for sentiment classes. These classes include positive, negative, and neutral sentences. 

## Task 3: Training Considerations
### Implications and advantages of scenarios and the rationale as to how the model should be trained
1. The entire network is frozen:
   - Implications and Advantages: All parameters like the transformer and task-specific heads are frozen. The model is then used as a static encoder. This is useful for feature extraction as training is fast and no gradient updates are required. Although it is rare, it would be useful if the pre-trained model performs significantly well on the tasks. This also would be less computationally expensive.
   - How the model should be trained: Use the transformer to extract embeddings (I used mean pooling). Pass the embeddings through a separate classifier and train it independently.
2. Only the transformer backbone should be frozen:
   - Implications and Advantages: The transformer stays stable which reduces overfitting on small datasets. Only task-specific classification heads are trainable; however, they are fast and easy to train. This would also preserve the linguistic knowledge that is captured during pre-training. 
   - How the model should be trained: Freeze the transformer parameters then use a loss function (I used cross-entropy) to define and train task-specific heads. Update the head parameters with a standard training loop.
3. Only one of the task-specific heads (either for Task A or Task B) should be frozen
   - Implications and Advantages: One task (Task A: Classification) is stable while the other task (Task B: Sentiment) is trained. This is useful for preventing catastrophic forgetting as it allows one task to improve without degrading the performance of the other task that performs well. The shared backbone is also updated. 
   - How the model should be trained: Freeze the well-performing task then update the head of the other task. Calculate the loss for only the updated task.

### Approaching the transfer learning process
The choice for the pre-trained model is the BERT-base transformer. This is because it is pre-trained on massive corpora which reduces the computational price and the need for large labeled datasets. It also provides a strong general language understanding and generates sufficient sentence embeddings. It even transfers well across tasks as it is widely supported and well-documented.
Initially, The embedding and transformer encoder layers are frozen. Train the task-specific heads. As training goes on, specifically mid-training, gradually unfreeze a few of the top layers of BERT so they may adapt to task-specific signals and improve performance. This also avoids catastrophic forgetting and reduces training time. Lastly, the entire model should be tuned with a low learning rate. During tuning, all BERT layers can be unfrozen. This allows the model to learn domain-specific context. 

## Task 4: Training Loop Implementation (BONUS)
The sentences are embedded through a shared BERT encoder to reduce model size, training time, and computational cost. Since each task has different output requirements, I created two separate task-specific heads. Dummy labels were created as hypothetical data to focus on the architecture of the model. Assuming the losses for each task are comparable in class, I used cross-entropy loss as the loss function for both tasks. Accuracy is used as an evaluation metric as this simple metric works well at tracking classification performance. Only one batch was used for simplicity; however, in practice, multiple batches would be used.

***The Jupyter Notebook for this assessment can be found here***
