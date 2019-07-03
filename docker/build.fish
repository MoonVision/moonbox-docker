#!/usr/bin/env fish

set docker_tag ""

if test "$DBI_ADDITIONALTAG"
    set docker_tag $DBI_ADDITIONALTAG
end

if test "$DBI_TAGVERSION"
    if test "$docker_tag"
        set docker_tag_latest "$docker_tag-latest"
        set docker_tag "$docker_tag-$DBI_TAGVERSION"
    else
        set docker_tag_latest "latest"
        set docker_tag "$DBI_TAGVERSION"
    end
end

set baseimage_param ""

set additional_buildargs

if test "$DBI_ADDITIONAL_BUILDARGS"
    apk add python3 py3-yaml jq
    alias yaml2json "python3 -c 'import yaml,json,sys; sys.stdout.write(json.dumps(yaml.load(sys.stdin), sort_keys=True, indent=2))'"
    alias object2buildargs 'jq --raw-output \'to_entries | map("--build-arg", "\(.key)=\(.value)") | join("\n")\''
    set additional_buildargs (echo $DBI_ADDITIONAL_BUILDARGS | yaml2json | object2buildargs)
end

echo additional_buildargs $additional_buildargs

if test "$DBI_BASEIMAGE"
    set baseimage_param --build-arg baseimage="$DBI_BASEIMAGE"
end

mkdir /ci
echo "$DBI_IMAGENAME:$docker_tag" | tee /ci/docker_main_tag.txt
echo "$DBI_IMAGENAME:$docker_tag" | tee /ci/docker_tags.txt
echo "$DBI_IMAGENAME:$docker_tag_latest" | tee /ci/docker_tags.txt

echo "$DOCKER_PASSWORD" | docker login -u $DOCKER_USER --password-stdin
if test "$DBI_BASEIMAGE" != "scratch"
    eval $DBI_DOCKEREXE pull "$DBI_BASEIMAGE"
end
pwd

docker build -f $DBI_DOCKERFILE -t $DBI_IMAGENAME:$docker_tag -t $DBI_IMAGENAME:$docker_tag_latest $baseimage_param $additional_buildargs "$DBI_PATH"
echo Build finished
docker images

echo "$DBI_IMAGENAME:$docker_tag_latest" | tee ~/imagename.txt
