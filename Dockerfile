# ---- Base Node ----
FROM chekote/node as base
# set working directory
WORKDIR /data
# copy project file
COPY package.json .

#
# ---- Dependencies ----
FROM base AS dependencies
# install node packages
RUN mkdir dog_park
RUN yarn install

#
# ---- Release ----
FROM base AS release
# copy production node_modules
COPY --from=dependencies /data/node_modules ./node_modules
# copy app sources
COPY . .
RUN yarn build

CMD ["/bin/bash"]
