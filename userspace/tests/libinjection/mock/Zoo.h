#pragma once

#include <libinjection/Entity.h>
#include <libutils/String.h>
#include <libutils/Vec.h>

struct Animal : public Injection::Entity
{
    virtual String speak() = 0;
};

struct Lion : public Animal
{
    virtual String speak() { return "Rhaaaa"; }
};

struct Cat : public Animal
{
    virtual String speak() { return "Maiou"; }
};

struct Dog : public Animal
{
    virtual String speak() { return "Bark"; }
};

struct Zoo : public Injection::Entity
{
    Vec<RefPtr<Animal>> _animals;

    INJECTOR(Zoo(Vec<RefPtr<Animal>> animal))
        : _animals{animal}
    {
    }
};