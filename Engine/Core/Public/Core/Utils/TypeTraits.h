#pragma once


#include <Core/Core.h>

namespace PixelLight
{
	/**
	 *	De-reference a type
	 */
	template <class T>
	struct RemoveRef
	{
		typedef T Type;
	};

	template <class T>
	struct RemoveRef<T&>
	{
		typedef T Type;
	};

	template <class T>
	struct RemoveRef<T&&>
	{
		typedef T Type;
	};

	/**
	 *	De-const a type
	 */
	template <class T>
	struct RemoveConst
	{
		typedef T Type;
	};

	template <class T>
	struct RemoveConst<const T>
	{
		typedef T Type;
	};

	/**
	*	De-volatile a type
	*/
	template <class T>
	struct RemoveVolatile
	{
		typedef T Type;
	};

	template <class T>
	struct RemoveVolatile<volatile T>
	{
		typedef T Type;
	};

	/**
	 *	Combination of RemoveConst and RemoveVolatile
	 */
	template <class T>
	struct RemoveCV
	{
		typedef typename RemoveVolatile<typename RemoveConst<T>::Type>::Type Type;
	};

	/**
	 *	Get base type of an array
	 */
	template <class T>
	struct RemoveExtent
	{
		typedef T Type;
	};

	template <class T>
	struct RemoveExtent<T[]>
	{
		typedef T Type;
	};

	PL_TODO(AM, "Should use size_t equivalent");
	template <class T, int N>
	struct RemoveExtent<T[N]>
	{
		typedef T Type;
	};

	/**
	 *	Compile type conditional
	 */
	template <bool B, class TrueT, class FalseT>
	struct StaticIf
	{
		typedef TrueT Type;
	};

	template <class TrueT, class FalseT>
	struct StaticIf<false, TrueT, FalseT>
	{
		typedef FalseT Type;
	};

	/**
	 *	Compile-time constant
	 */
	template <class T, T Val>
	struct StaticConst
	{
		static T Value = Val;

		typedef T ValueType;
		typedef StaticConst Type;
	};

	typedef StaticConst<bool, true> StaticTrue;
	typedef StaticConst<bool, false> StaticFalse;

	/**
	*	Check if given type is an array
	*/
	template <class T>
	struct IsArray : StaticFalse {};

	template <class T>
	struct IsArray<T[]> : StaticTrue {};

	PL_TODO(AM, "Should use size_t equivalent");
	template <class T, int N>
	struct IsArray<T[N]> : StaticTrue {};

	/**
	 *	Check if given type is a function
	 */
	template<class>
	struct IsFunction : StaticFalse {};

	// Specialization for regular functions
	template<class Ret, class... Args>
	struct IsFunction<Ret(Args...)> : StaticTrue {};

	// Specialization for variadic functions such as std::printf
	template<class Ret, class... Args>
	struct IsFunction<Ret(Args..., ...)> : StaticTrue {};

	// specialization for function types that have cv-qualifiers
	template<class Ret, class... Args>
	struct IsFunction<Ret(Args...)const> : StaticTrue {};
	template<class Ret, class... Args>
	struct IsFunction<Ret(Args...)volatile> : StaticTrue {};
	template<class Ret, class... Args>
	struct IsFunction<Ret(Args...)const volatile> : StaticTrue {};
	template<class Ret, class... Args>
	struct IsFunction<Ret(Args..., ...)const> : StaticTrue {};
	template<class Ret, class... Args>
	struct IsFunction<Ret(Args..., ...)volatile> : StaticTrue {};
	template<class Ret, class... Args>
	struct IsFunction<Ret(Args..., ...)const volatile> : StaticTrue {};

	// Specialization for function types that have ref-qualifiers
	template<class Ret, class... Args>
	struct IsFunction<Ret(Args...) &> : StaticTrue {};
	template<class Ret, class... Args>
	struct IsFunction<Ret(Args...)const &> : StaticTrue {};
	template<class Ret, class... Args>
	struct IsFunction<Ret(Args...)volatile &> : StaticTrue {};
	template<class Ret, class... Args>
	struct IsFunction<Ret(Args...)const volatile &> : StaticTrue {};
	template<class Ret, class... Args>
	struct IsFunction<Ret(Args..., ...) &> : StaticTrue {};
	template<class Ret, class... Args>
	struct IsFunction<Ret(Args..., ...)const &> : StaticTrue {};
	template<class Ret, class... Args>
	struct IsFunction<Ret(Args..., ...)volatile &> : StaticTrue {};
	template<class Ret, class... Args>
	struct IsFunction<Ret(Args..., ...)const volatile &> : StaticTrue {};
	template<class Ret, class... Args>
	struct IsFunction<Ret(Args...) && > : StaticTrue {};
	template<class Ret, class... Args>
	struct IsFunction<Ret(Args...)const &&> : StaticTrue {};
	template<class Ret, class... Args>
	struct IsFunction<Ret(Args...)volatile &&> : StaticTrue {};
	template<class Ret, class... Args>
	struct IsFunction<Ret(Args...)const volatile &&> : StaticTrue {};
	template<class Ret, class... Args>
	struct IsFunction<Ret(Args..., ...) && > : StaticTrue {};
	template<class Ret, class... Args>
	struct IsFunction<Ret(Args..., ...)const &&> : StaticTrue {};
	template<class Ret, class... Args>
	struct IsFunction<Ret(Args..., ...)volatile &&> : StaticTrue {};
	template<class Ret, class... Args>
	struct IsFunction<Ret(Args..., ...)const volatile &&> : StaticTrue {};

	/**
	 *	Check if given type is a function pointer
	 */
	template<class>
	struct IsFunctionPtr : StaticFalse {};

	// Specialization for regular functions
	template<class Ret, class... Args>
	struct IsFunctionPtr<Ret(*)(Args...)> : StaticTrue {};

	// Specialization for variadic functions such as std::printf
	template<class Ret, class... Args>
	struct IsFunctionPtr<Ret(*)(Args..., ...)> : StaticTrue {};

	/**
	 *	Attach a pointer to type
	 */
	namespace Internal
	{
		template <class T, bool IsFunction = false>
		struct AddPointer
		{
			typedef typename RemoveRef<T>::Type* Type;
		};

		template <class T>
		struct AddPointer<T, true>
		{
			typedef T Type;
		};

		template <class T, class... Args>
		struct AddPointer<T(Args...), true>
		{
			typedef T(*Type)(Args...);
		};

		template <class T, class... Args>
		struct AddPointer<T(Args..., ...), true>
		{
			typedef T(*Type)(Args..., ...);
		};
	}

	template <class T>
	struct AddPointer : Internal::AddPointer<T, IsFunction<T>::Value> {};

	template <class T>
	using AddPointerT = typename AddPointer<T>::Type;

	/**
	 *	Apply implicit conversion to a type
	 *	Basically the same as what would happen if T was passed into a function by value
	 */
	template <class T>
	struct Decay
	{
	private:
		typedef typename RemoveRef<T>::Type U;

	public:
		typedef typename StaticIf<
			IsArray<U>::Value,
			typename RemoveExtent<U>::Type,
			typename StaticIf<
				sFunction<U>::Value,
				typename AddPointer<U>::Type,
				typename RemoveCV<U>::Type
			>::Type
		>::Type Type;
	};
}
