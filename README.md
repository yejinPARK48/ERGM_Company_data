# ERGM_Company_data
Park YJ, Um JM, Hong SB, Han YJ, and Kim JH* (2022). Statistical ERGM Analysis for Consulting Company  Network Data, The Korean Journal of Applied Statistics, 35(4) 527-541.

#### This study aims to investigate the factors influencing the formation of advice-giving relationships within a consulting company's workplace network. Using the Exponential Random Graph Model (ERGM), we analyze network data from 44 employees across offices in the United States and Europe.

##### The main objectives of this research are:

1. To identify which employees play a significant role in the advice network.

2. To determine which employee characteristics, such as gender, rank, and geographical location, influence the likelihood of forming advice-giving relationships.

3. To explore whether homophily (similarity between individuals) or heterophily (differences between individuals) exists in the advice network.

#### Through this research, we aim to provide insights into improving workplace network efficiency and communication by identifying key factors that influence the creation of advice relationships.

#### Keywords: company network, ERGM, network data, reciprocity, transitivity 


| **Variable**       | **Model 1** |           | **Model 2** |           | **Model 3** |           |
|--------------------|-------------|-----------|-------------|-----------|-------------|-----------|
| **Relationships**   | Estimate    | Std. Error| Estimate    | Std. Error| Estimate    | Std. Error|
| Connectivity       | -0.968***   | 0.051     | -10.189***  | 1.334     | -8.849***   | 0.998     |
| Advice Provision   |             |           | 0.042***    | 0.010     | 0.041*      | 0.017     |
| Reciprocity        |             |           | 3.258***    | 0.204     | 2.719***    | 0.211     |
| Transitivity       |             |           | 5.751***    | 1.112     | 3.886***    | 0.852     |
| **Homophily**      |             |           |             |           |             |           |
| Europe             |             |           |             |           | 1.139***    | 0.139     |
| USA                |             |           |             |           | 1.816***    | 0.128     |
| **Covariates**     |             |           |             |           |             |           |
| Female             |             |           |             |           | -0.400**    | 0.049     |
| Rank               |             |           |             |           | 0.161**     | 0.151     |
| **Model Fit**      |             |           |             |           |             |           |
| AIC                | 2229        |           | 1694        |           | 1403        |           |
| BIC                | 2235        |           | 1717        |           | 1448        |           |

* : p < 0.01, ** : p < 0.01, *** : p < 0.001



**Model 1:**

$$
P(Y = y) = \exp \{ -0.968 S_{1}(y) \}, \quad y \in Y.
$$

**Model 2:**

$$
P(Y = y) = \exp \{ -10.189 S_{1}(y) + 0.042 S_{2}(y) + 3.258 M(y) + 5.751 T(y) \}, \quad y \in Y.
$$

**Model 3:**

$$
P(Y = y) = \exp \{ -8.849 S_{1}(y) + 0.041 S_{2}(y) + 2.719 M(y) + 3.886 T(y) + 1.139 a_{ij} + 1.181 b_{ij} - 0.400 (l_{i} + l_{j}) + 0.161 (g_{i} + g_{j}) \}, \quad y \in Y.
$$


<p align="center">
  <img src="https://github.com/user-attachments/assets/42ce72fa-2423-4e0b-9d50-cd75af3f0d89">
</p>

Data: Cross R and Parker A (2004). The Hidden Power of Social Networks: Understanding How Work Really Gets Done in Organizations, Harvard Business School Press, Boston

